resource "kubernetes_namespace_v1" "argocd" {
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
    namespace = kubernetes_namespace_v1.argocd.metadata[0].name
  }

  type = "Opaque"

  data_wo_revision = 2
  data_wo = {
    "admin.password" = bcrypt(ephemeral.sops_file.secrets.data["argocd.admin-password"])
    "admin.passwordMtime" = timestamp()
    "server.secretkey" = ephemeral.sops_file.secrets.data["argocd.server-secretkey"]
    "webhook.github.secret" = ephemeral.sops_file.secrets.data["github-webhooks.secret"]
  }

  lifecycle {
    ignore_changes = [ metadata ]
  }
}
