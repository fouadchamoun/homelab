resource "cloudflare_zero_trust_dns_location" "warp" {
  account_id             = local.account_id
  name                   = "WARP"
  client_default         = true
  
  networks               = []
}

resource "cloudflare_zero_trust_dns_location" "freebox" {
  account_id             = local.account_id
  name                   = "Freebox"
  
  networks = [{
    network = data.sops_file.secrets.data["cidr.home"]
  }]
}

resource "cloudflare_zero_trust_dns_location" "fadi" {
  account_id             = local.account_id
  name                   = "Fadi"
  
  networks               = []
}

resource "cloudflare_zero_trust_dns_location" "tailscale" {
  account_id             = local.account_id
  name                   = "Tailscale"
  
  networks = []
  endpoints = {
    doh = {
      enabled = false
    }
    dot = {
      enabled = false
    }
    ipv4 = {
      enabled = false
    }
    ipv6 = {
      enabled = true
    }
  }
}