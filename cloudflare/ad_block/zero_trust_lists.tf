data "http" "oisd_small" {
  url = "https://small.oisd.nl/domainswild"
}

locals {
  # Parse the file and create a list, one item per line
  domain_list_raw = split("\n", data.http.oisd_small.response_body)

  # Remove empty lines, comments, and remove wildcard
  domain_list = [for x in local.domain_list_raw : replace(x, "*.", "") if x != "" && !startswith(x, "#")]

  # Use chunklist to split a list into fixed-size chunks
  aggregated_lists = chunklist(local.domain_list, 1000)
}

resource "cloudflare_zero_trust_list" "allowlist" {
  account_id = local.account_id

  name  = "allowlist"
  type  = "DOMAIN"
  items = [
    # empty for now
    # { value = item }
  ]
}

resource "cloudflare_zero_trust_list" "ads_domain_list" {
  account_id = local.account_id

  for_each = {
    for i in range(0, length(local.aggregated_lists)) :
      i => element(local.aggregated_lists, i)
  }

  name  = "ads_domain_list_${each.key}"
  type  = "DOMAIN"
  items = [for item in each.value : { value = item }]
}
