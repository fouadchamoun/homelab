resource "cloudflare_dns_record" "redirect_root_to_blog" {
  comment = "Created during Cloudflare Rules deployment process for Redirect Root to Blog"
  content = "blog.fouad.dev"
  name    = "fouad.dev"
  proxied = true
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = local.zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "wildcard_oracle" {
  content = "oracle.fouad.dev"
  name    = "*.oracle.fouad.dev"
  proxied = false
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = local.zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "icloud_dkim_cname" {
  content = "sig1.dkim.fouad.dev.at.icloudmailadmin.com"
  name    = "sig1._domainkey.fouad.dev"
  proxied = false
  tags    = []
  ttl     = 3600
  type    = "CNAME"
  zone_id = local.zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "redirect_www_to_root" {
  comment = "Created during Cloudflare Rules deployment process for Redirect from WWW to Root"
  content = "fouad.dev"
  name    = "www.fouad.dev"
  proxied = true
  tags    = []
  ttl     = 1
  type    = "CNAME"
  zone_id = local.zone_id
  settings = {
    flatten_cname = false
  }
}

resource "cloudflare_dns_record" "icloud_mx_1" {
  content  = "mx01.mail.icloud.com"
  name     = "fouad.dev"
  priority = 10
  proxied  = false
  tags     = []
  ttl      = 3600
  type     = "MX"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "icloud_mx_2" {
  content  = "mx02.mail.icloud.com"
  name     = "fouad.dev"
  priority = 10
  proxied  = false
  tags     = []
  ttl      = 3600
  type     = "MX"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "apple_domain_verification_txt_1" {
  content  = "\"apple-domain=9y9m7Jp8CdTOMeom\""
  name     = "fouad.dev"
  proxied  = false
  tags     = []
  ttl      = 3600
  type     = "TXT"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "spf_txt" {
  content  = "\"v=spf1 include:spf.mailjet.com include:icloud.com ~all\""
  name     = "fouad.dev"
  proxied  = false
  tags     = []
  ttl      = 3600
  type     = "TXT"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "keybase_verification_txt" {
  content  = "\"keybase-site-verification=hihyvb_mjB3lwiIUNKj16_zIrgi_vn43r1laeqnLgeQ\""
  name     = "fouad.dev"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "apple_domain_verification_txt_2" {
  content  = "\"apple-domain=UJNZJLatHjAa4CwV\""
  name     = "fouad.dev"
  proxied  = false
  tags     = []
  ttl      = 3600
  type     = "TXT"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "mailjet_verification_txt" {
  content  = "\"7959172fe0154db262fbfeadbc06ef7d\""
  name     = "mailjet._7959172f.fouad.dev"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = local.zone_id
  settings = {}
}

resource "cloudflare_dns_record" "mailjet_dkim_txt" {
  content  = "\"k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCwoWcmOm7yPL9Eqy1fBuy/ojDIdDke+/7oW+WzWi4r6cqkABB6Ffxr2oUCWnRFA0/BnJ3sXbqRb6xRSoiDUjOw5sRu9Aw2uayGKecvVppNKT1TmVtN94AZeAVUIE1BS1UhnqKCESmdqE6wKkUjaKtTyeszQAWlzWlIW2uZegWPrQIDAQAB\""
  name     = "mailjet._domainkey.fouad.dev"
  proxied  = false
  tags     = []
  ttl      = 1
  type     = "TXT"
  zone_id  = local.zone_id
  settings = {}
}
