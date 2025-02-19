resource "proxmox_virtual_environment_acme_dns_plugin" "cloudflare" {
  api    = "cf"
  plugin = "cloudflare"
  validation_delay = 0
  data = {
    CF_Account_ID = data.hcp_vault_secrets_app.pve.secrets["cloudflare_account_id"]
    CF_Email = data.hcp_vault_secrets_app.pve.secrets["cloudflare_email"]
    CF_Key = data.hcp_vault_secrets_app.pve.secrets["cloudflare_key"]
    CF_Token = data.hcp_vault_secrets_app.pve.secrets["cloudflare_token"]
    CF_Zone_ID = data.hcp_vault_secrets_app.pve.secrets["cloudflare_zone_id"]
  }
}
