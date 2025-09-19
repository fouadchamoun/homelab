terraform {
  cloud {
    organization = "fouadflix"

    workspaces {
      name = "ad_block"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.10"
    }
    http = {
      source = "hashicorp/http"
      version = "~> 3"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

