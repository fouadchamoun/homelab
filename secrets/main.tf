terraform {
  cloud {
    organization = "fouadflix"

    workspaces {
      name = "secrets"
    }
  }

  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "0.111.0"
    }
    sops = {
      source = "carlpett/sops"
      version = "1.4.1"
    }
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.74.0"
    }
  }
}

provider "hcp" {}

provider "sops" {}

provider "scaleway" {
  profile = "personal-secrets-manager"
}
