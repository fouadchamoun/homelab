terraform { 
  cloud { 
    organization = "fouadflix" 

    workspaces {
      name = "pve" 
    } 
  }

  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "~> 0.102"
    }
    proxmox = {
      source = "bpg/proxmox"
      version = "~> 0.72"
    }
    sops = {
      source = "carlpett/sops"
      version = "~> 1.2"
    }
  }
}

provider "hcp" {}

provider "sops" {}

data "sops_file" "secrets" {
  source_file = "secrets.yaml"
}

provider "proxmox" {
  endpoint = "https://pve-0.homelab.fouad.dev:8006"

  # Choose one authentication method:
  api_token = data.sops_file.secrets.data["pve.cluster_api_token"]
}
