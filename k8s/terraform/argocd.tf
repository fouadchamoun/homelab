resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
    labels = {
      "name" = "argocd"
    }
  }
}

resource "kubernetes_secret_v1" "argocd_secret" {
  metadata {
    name = "argocd-secret"
    namespace = kubernetes_namespace.argocd.metadata[0].name
  }

  type = "Opaque"

  data_wo_revision = 2
  data_wo = {
    "admin.password" = bcrypt(ephemeral.sops_file.secrets.data["argocd.admin-password"])
    "admin.passwordMtime" = timestamp()
    "server.secretkey" = ephemeral.sops_file.secrets.data["argocd.server-secretkey"]
    "webhook.github.secret" = ephemeral.sops_file.secrets.data["github-webhooks.pull-requests"]
  }

  lifecycle {
    ignore_changes = [ metadata ]
  }
}

resource "helm_release" "argocd" {
  depends_on = [ kubernetes_secret_v1.argocd_secret ]

  name             = "argocd"
  namespace        = kubernetes_namespace.argocd.metadata[0].name
  create_namespace = true # not needed anymore

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
      "https://traefik.github.io/charts",
      "https://grafana.github.io/helm-charts"
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
    destination {
      server = "https://kubernetes.default.svc"
      namespace = "monitoring"
    }
  }
}

# Application - Cluster Bootstrap
resource "argocd_application" "cluster_bootstrap" {
  depends_on = [ argocd_project.cluster_bootstrap ]

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
