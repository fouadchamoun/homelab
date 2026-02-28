resource "cloudflare_zero_trust_gateway_policy" "block_security_risks" {
  account_id    = local.account_id
  description   = ""
  action        = "block"
  enabled       = true
  filters       = ["dns"]
  name          = "Block Security Risks"
  precedence    = 13000
  traffic       = "any(dns.security_category[*] in {68 178 80 83 176 175 117 131 134 151 153}) and not(any(dns.security_category[*] in {68}))"
  rule_settings = {
    block_reason = "This page is a security risk."
    notification_settings = {
      enabled = true
    }
  }
}

resource "cloudflare_zero_trust_gateway_policy" "block_lg_tv_updates" {
  account_id    = local.account_id
  description   = ""
  action        = "block"
  enabled       = false
  filters       = ["dns"]
  name          = "Block LG TV updates"
  precedence    = 1000864
  traffic       = "any(dns.domains[*] == \"snu.lge.com\") and dns.location in {\"${cloudflare_zero_trust_dns_location.freebox.id}\"}"
}

resource "cloudflare_zero_trust_gateway_policy" "override_oracle" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "oracle.fouad.dev"
  precedence    = 1001363
  traffic       = "dns.location in {\"${cloudflare_zero_trust_dns_location.warp.id}\" \"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\"} and any(dns.domains[*] == \"oracle.fouad.dev\")"
  rule_settings = {
    override_ips = ["10.0.0.64"]
  }
}

resource "cloudflare_zero_trust_gateway_policy" "override_unraid" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "Traefik"
  precedence    = 1003363
  traffic       = "any(dns.domains[*] in {\"unraid.fouad.dev\" \"home.fouad.dev\"}) and dns.location in {\"${cloudflare_zero_trust_dns_location.warp.id}\" \"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\"}"
  rule_settings = {
    override_ips = ["192.168.200.10"]
  }
}

resource "cloudflare_zero_trust_gateway_policy" "override_pve_0" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "pve-0"
  precedence    = 1004363
  traffic       = "any(dns.domains[*] == \"pve-0.homelab.fouad.dev\") and dns.location in {\"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\" \"${cloudflare_zero_trust_dns_location.warp.id}\"}"
  rule_settings = {
    override_ips = ["192.168.200.20"]
  }
}

resource "cloudflare_zero_trust_gateway_policy" "override_pve_1" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "pve-1"
  precedence    = 1004373
  traffic       = "any(dns.domains[*] == \"pve-1.homelab.fouad.dev\") and dns.location in {\"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\" \"${cloudflare_zero_trust_dns_location.warp.id}\"}"
  rule_settings = {
    override_ips = ["192.168.200.30"]
  }
}

resource "cloudflare_zero_trust_gateway_policy" "override_pve_2" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "pve-2"
  precedence    = 1004383
  traffic       = "any(dns.domains[*] == \"pve-2.homelab.fouad.dev\") and dns.location in {\"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\" \"${cloudflare_zero_trust_dns_location.warp.id}\"}"
  rule_settings = {
    override_ips = ["192.168.200.40"]
  }
}

resource "cloudflare_zero_trust_gateway_policy" "override_talos_cluster_entrypoint" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "talos-cluster"
  precedence    = 1006360
  traffic       = "any(dns.domains[*] == \"talos.homelab.fouad.dev\") and dns.location in {\"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\" \"${cloudflare_zero_trust_dns_location.warp.id}\"}"
  rule_settings = {
    override_ips = ["192.168.200.60", "192.168.200.61", "192.168.200.62"]
  }
}

resource "cloudflare_zero_trust_gateway_policy" "override_talos_traefik_vip" {
  account_id    = local.account_id
  description   = ""
  action        = "override"
  enabled       = true
  filters       = ["dns"]
  name          = "talos-traefik-vip"
  precedence    = 1006361
  traffic       = "any(dns.domains[*] == \"homelab.fouad.dev\") and dns.location in {\"${cloudflare_zero_trust_dns_location.freebox.id}\" \"${cloudflare_zero_trust_dns_location.tailscale.id}\" \"${cloudflare_zero_trust_dns_location.warp.id}\"}"
  rule_settings = {
    override_ips = ["192.168.200.80"]
  }
}