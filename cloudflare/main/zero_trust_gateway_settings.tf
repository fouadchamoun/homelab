resource "cloudflare_zero_trust_gateway_settings" "main" {
  account_id = local.account_id

  settings = {
    activity_log = {
      enabled = true
    }

    certificate = {
      id = "c4a5bef6-f30f-4d5d-96af-5ca0f139ca73"
    }

    fips = null

    tls_decrypt = {
      enabled = false
    }
  }
}
