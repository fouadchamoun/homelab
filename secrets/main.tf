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
      version = "~> 0.102"
    }
    sops = {
      source = "carlpett/sops"
      version = "~> 1.3"
    }
    scaleway = {
      source = "scaleway/scaleway"
      version = "~> 2.69"
    }
  }
}

provider "hcp" {}

provider "sops" {}

provider "scaleway" {
  profile = "personal-secrets-manager"
}
