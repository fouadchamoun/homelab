resource "proxmox_virtual_environment_container" "kube" {
  count = 3

  description = "Managed by Terraform"
  tags        = ["terraform", "kube"]

  start_on_boot = true
  started = false

  node_name = "pve-0"
  vm_id     = 200 + count.index

  unprivileged = false

  operating_system {
    type             = "debian"
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

#   features {
#     nesting = true
#   }

  initialization {
    hostname = "kube-${count.index}"

    ip_config {
      ipv4 {
        address = "192.168.200.${ 26 + count.index }/32"
        gateway = "192.168.200.1"
      }
    }

    dns {
      servers = [
        "1.1.1.1",
        "1.0.0.1"
      ]
    }

    user_account {
      keys = [
        trimspace(data.http.github_user_key.response_body)
      ]
    }
  }

  cpu {
    cores = 4
  }

  memory {
    dedicated = 8192
  }

  network_interface {
    name = "veth0"
    enabled = true
    firewall = false
  }


  disk {
    datastore_id      = "linstor-repl"
    size              = 128
  }

  # device_passthrough {

  # }

  lifecycle {
    ignore_changes = [node_name, started]
  }
}
