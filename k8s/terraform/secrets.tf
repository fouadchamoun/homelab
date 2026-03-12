ephemeral "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

resource "kubernetes_namespace" "external_secrets" {
  metadata {
    name = "external-secrets"
    labels = {
      "name" = "external-secrets"
    }
  }
}

resource "kubernetes_secret_v1" "scw_sm_secret" {
  metadata {
    name = "scw-sm-secret"
    namespace = kubernetes_namespace.external_secrets.metadata[0].name
  }

  type = "Opaque"

  data_wo_revision = 1
  data_wo = {
    access-key = ephemeral.sops_file.secrets.data["scw-sm-secret.access-key"]
    secret-key = ephemeral.sops_file.secrets.data["scw-sm-secret.secret-key"]
  }
}
