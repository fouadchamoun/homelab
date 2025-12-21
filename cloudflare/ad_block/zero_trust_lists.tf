data "http" "oisd_small" {
  url = "https://small.oisd.nl/domainswild"
  request_timeout_ms = 60000
}

locals {
  # Parse the file and create a list, one item per line
  domain_list_raw = split("\n", data.http.oisd_small.response_body)

  # Remove empty lines, comments, and remove wildcard
  domain_list = [
    for x in local.domain_list_raw :
    replace(x, "*.", "")
    if x != "" && !startswith(x, "#")
  ]

  max_ads_lists = 70

  # Use chunklist to split a list into fixed-size chunks
  chunks = chunklist(local.domain_list, 1000)

  # Cap to max size
  capped_ads_lists = slice(local.chunks, 0, min(local.max_ads_lists, length(local.chunks)))

  # pad with empty lists so we always have max_ads_lists entries
  padding = [for i in range(length(local.capped_ads_lists), local.max_ads_lists) : []]
  padded_ads_lists = concat(local.capped_ads_lists, local.padding)
}

resource "cloudflare_zero_trust_list" "allowlist" {
  account_id = var.cloudflare_account_id

  name  = "allowlist"
  type  = "DOMAIN"
  # items = [
  #   # empty for now
  #   # { value = item }
  # ]
}

resource "cloudflare_zero_trust_list" "ads_domain_list" {
  account_id = var.cloudflare_account_id

  for_each = {
    for i, chunk in local.padded_ads_lists :
      i => chunk
  }

  name  = "ads_domain_list_${each.key}"
  type  = "DOMAIN"
  items = [for item in each.value : { value = item }]
}
