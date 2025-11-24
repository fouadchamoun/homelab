resource "cloudflare_zero_trust_gateway_settings" "main" {
  account_id = local.account_id

  settings = {
    activity_log = {
      enabled = true
    }

    certificate = {
      id = cloudflare_zero_trust_gateway_certificate.main.id
    }

    fips = null

    tls_decrypt = {
      enabled = false
    }
  }
}

resource "cloudflare_zero_trust_gateway_certificate" "main" {
  account_id = local.account_id
}