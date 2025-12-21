locals {
  # Iterate through each ads_domain_list resource and extract its ID
  ads_domain_list_ids = [
    for k, v in cloudflare_zero_trust_list.ads_domain_list :
    format("$%s", replace(v.id, "-", "")) # remove dashes and prepend $
  ]

  block_ads_filter_expressions = formatlist("any(dns.domains[*] in %s)", local.ads_domain_list_ids)
}

resource "cloudflare_zero_trust_gateway_policy" "allowlist" {
  account_id = var.cloudflare_account_id

  name        = "Allowlist"
  description = "Domains explicitly allowed"

  enabled    = true
  precedence = 1999

  filters = ["dns"]
  action  = "allow"
  traffic = "any(dns.domains[*] in ${format("$%s", replace(cloudflare_zero_trust_list.allowlist.id, "-", ""))})"
}

resource "cloudflare_zero_trust_gateway_policy" "block_ads" {
  account_id = var.cloudflare_account_id

  name        = "Block Ads"
  description = "Block Ad domains"

  enabled    = true
  precedence = 2000

  filters = ["dns"]
  action  = "block"
  traffic = join(" or ", local.block_ads_filter_expressions)

  lifecycle {
    precondition {
      condition     = length(local.chunks) <= local.max_ads_lists
      error_message = "Too many ads domain chunks: length(chunks) = ${length(local.chunks)}, but max_ads_lists = ${local.max_ads_lists}. Increase max_ads_lists."
    }
  }
}
