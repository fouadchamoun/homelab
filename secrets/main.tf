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
      version = "1.3.0"
    }
    scaleway = {
      source = "scaleway/scaleway"
      version = "2.70.1"
    }
  }
}

provider "hcp" {}

provider "sops" {}

provider "scaleway" {
  profile = "personal-secrets-manager"
}
