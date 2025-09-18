resource "proxmox_virtual_environment_acme_dns_plugin" "cloudflare" {
  api    = "cf"
  plugin = "cloudflare"
  validation_delay = 0
  data = {
    CF_Account_ID = data.sops_file.secrets.data["cloudflare.account_id"]
    CF_Email = data.sops_file.secrets.data["cloudflare.email"]
    CF_Key = data.sops_file.secrets.data["cloudflare.key"]
    CF_Token = data.sops_file.secrets.data["cloudflare.token"]
    CF_Zone_ID = data.sops_file.secrets.data["cloudflare.zone_id"]
  }
}
