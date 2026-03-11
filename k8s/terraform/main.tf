terraform {
  cloud {
    organization = "fouadflix"

    workspaces {
      name = "k8s"
    }
  }

  required_providers {
    hcp = {
      source = "hashicorp/hcp"
      version = "~> 0.102"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 3"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 3"
    }
    argocd = {
      source = "argoproj-labs/argocd"
      version = "~> 7"
    }
  }
}

provider "hcp" {}

provider "kubernetes" {
  config_path = "~/.kube/configs/fouadflix-talos"
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/configs/fouadflix-talos"
  }
}

provider "argocd" {
  use_local_config = true
  # context = "foo" # Use explicit context from ArgoCD config instead of `current-context`.
}
