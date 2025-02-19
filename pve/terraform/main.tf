terraform { 
  cloud { 
    organization = "fouadflix" 

    workspaces { 
      name = "homelab" 
    } 
  }

  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "0.102.0"
    }
    proxmox = {
      source = "bpg/proxmox"
      version = "0.72.0"
    }
  }
}

provider "hcp" {}

provider "proxmox" {
  endpoint = "https://pve-0.homelab.fouad.dev:8006"

  # Choose one authentication method:
  api_token = data.hcp_vault_secrets_app.pve.secrets["pve_cluster_api_token"]
}

data "hcp_vault_secrets_app" "pve" {
  app_name = "pve"
}
