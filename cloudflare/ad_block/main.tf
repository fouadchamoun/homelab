terraform {
  required_version = "1.14.8"

  cloud {
    organization = "fouadflix"

    workspaces {
      name = "ad_block"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.10.1"
    }
    http = {
      source = "hashicorp/http"
      version = "3.5.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

