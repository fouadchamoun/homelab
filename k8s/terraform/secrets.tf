ephemeral "sops_file" "secrets" {
  source_file = "secrets.sops.yaml"
}

resource "kubernetes_namespace_v1" "external_secrets" {
  metadata {
    name = "external-secrets"
    labels = {
      "name" = "external-secrets"
    }
  }
}

resource "kubernetes_namespace_v1" "piraeus_datastore" {
  metadata {
    name = "piraeus-datastore"
    labels = {
      "name" = "piraeus-datastore"
    }
  }
}

resource "kubernetes_secret_v1" "scw_sm_secret" {
  metadata {
    name = "scw-sm-secret"
    namespace = kubernetes_namespace_v1.external_secrets.metadata[0].name
  }

  type = "Opaque"

  data_wo_revision = 1
  data_wo = {
    access-key = ephemeral.sops_file.secrets.data["scw-sm-secret.access-key"]
    secret-key = ephemeral.sops_file.secrets.data["scw-sm-secret.secret-key"]
  }
}


resource "kubernetes_secret_v1" "scw_linstor_remote_secret" {
  metadata {
    name = "scw-linstor-remote-secret"
    namespace = kubernetes_namespace_v1.piraeus_datastore.metadata[0].name
  }

  type = "linstor.csi.linbit.com/s3-credentials.v1"
  immutable = true

  data_wo_revision = 1
  data_wo = {
    access-key = ephemeral.sops_file.secrets.data["scw-linstor-remote-secret.access-key"]
    secret-key = ephemeral.sops_file.secrets.data["scw-linstor-remote-secret.secret-key"]
  }
}
