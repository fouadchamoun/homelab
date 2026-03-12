resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"

  values = [
    file("values/argocd.yaml")
  ]
}

resource "argocd_project" "cluster_bootstrap" {
  depends_on = [
    helm_release.argocd,
    kubernetes_secret_v1.scw_sm_secret
  ]

  metadata {
    name      = "cluster-bootstrap"
    namespace = "argocd"
  }

  spec {
    description = "Cluster Bootstrap"

    source_repos = [
      "https://github.com/fouadchamoun/homelab.git",
      "https://kube-vip.github.io/helm-charts",
      "ghcr.io/piraeusdatastore/piraeus-operator",
      "ghcr.io/piraeusdatastore/helm-charts",
      "quay.io/jetstack/charts",
      "https://charts.external-secrets.io",
      "https://traefik.github.io/charts"
    ]

    cluster_resource_whitelist {
      group = "*"
      kind  = "*"
    }

    destination {
      server = "https://kubernetes.default.svc"
      namespace = "argocd"
    }
    destination {
      server = "https://kubernetes.default.svc"
      namespace = "kube-system"
    }
    destination {
      server = "https://kubernetes.default.svc"
      namespace = "piraeus-datastore"
    }
    destination {
      server = "https://kubernetes.default.svc"
      namespace = "external-secrets"
    }
    destination {
      server = "https://kubernetes.default.svc"
      namespace = "cert-manager"
    }
    destination {
      server = "https://kubernetes.default.svc"
      namespace = "traefik"
    }
  }
}

# Application - Cluster Bootstrap
resource "argocd_application" "cluster_bootstrap" {
  depends_on = [ helm_release.argocd ]

  metadata {
    name = "cluster-bootstrap"
  }

  spec {
    project = argocd_project.cluster_bootstrap.metadata[0].name

    source {
      repo_url        = "https://github.com/fouadchamoun/homelab.git"
      target_revision = "main"
      path            = "k8s/bootstrap"
    }

    destination {
      server    = "https://kubernetes.default.svc"
      namespace = "argocd"
    }

    sync_policy {
      automated {
        prune       = false
        allow_empty = false
        self_heal   = true
      }
    }
  }
}
