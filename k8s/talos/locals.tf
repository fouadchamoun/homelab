locals {
  cluster_name = "fouadflix-talos"

  # renovate: datasource=github-releases depName=siderolabs/talos
  talos_version = "v1.13.0"
  # renovate: datasource=github-releases depName=kubernetes/kubernetes
  kubernetes_version = "v1.35.0"

  cluster_endpoint = "https://talos.homelab.fouad.dev:6443"
  talos_vip = "192.168.200.70"

  nodes = {
    controlplane = {
      talos-cp-00 = {
        ip = "192.168.200.60"
      },
      talos-cp-01 = {
        ip = "192.168.200.61"
      },
      talos-cp-02 = {
        ip = "192.168.200.62"
      }
    }
  }

  machine_secrets = jsondecode(
    jsondecode(
      base64decode(ephemeral.scaleway_secret_version.talos_secrets_v1.data)
    )["machine_secrets"]
  )
}
