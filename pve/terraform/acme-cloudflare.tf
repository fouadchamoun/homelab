resource "proxmox_acme_dns_plugin" "cloudflare" {
  api              = "cf"
  plugin           = "cloudflare"
  validation_delay = 0
  data = {
    CF_Account_ID = data.sops_file.secrets.data["cloudflare.account_id"]
    CF_Email      = data.sops_file.secrets.data["cloudflare.email"]
    CF_Key        = data.sops_file.secrets.data["cloudflare.key"]
    CF_Token      = data.sops_file.secrets.data["cloudflare.token"]
    CF_Zone_ID    = data.sops_file.secrets.data["cloudflare.zone_id"]
  }
}

resource "proxmox_acme_account" "default" {
  provider = proxmox.root

  name      = "default"
  contact   = "mail@fouad.dev"
  directory = "https://acme-v02.api.letsencrypt.org/directory"
  tos       = "https://letsencrypt.org/documents/LE-SA-v1.4-April-3-2024.pdf"
}

resource "proxmox_acme_certificate" "webui_certificate" {
  for_each = toset(["pve-0", "pve-1", "pve-2"])

  node_name = each.value
  account   = proxmox_acme_account.default.name

  domains = [
    {
      domain = "${each.value}.homelab.fouad.dev"
      plugin = proxmox_acme_dns_plugin.cloudflare.plugin
    }
  ]

  lifecycle {
    ignore_changes = []
  }
}
