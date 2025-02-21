data "http" "github_user_key" {
  url = "https://github.com/fouadchamoun.keys"
}

resource "proxmox_virtual_environment_container" "docker_00" {
  description = "Managed by Terraform"
  tags        = ["terraform", "docker"]

  start_on_boot = true
  started = false

  node_name = "pve-0"
  vm_id     = 101

  unprivileged = true

  operating_system {
    type             = "debian"
    template_file_id = "local:vztmpl/debian-12-standard_12.7-1_amd64.tar.zst"
  }

  features {
    nesting = true
  }

  initialization {
    hostname = "docker-00"

    ip_config {
      ipv4 {
        address = "192.168.200.23/32"
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
    cores = 8
  }

  memory {
    dedicated = 16384
  }

  network_interface {
    name = "veth0"
    enabled = true
    firewall = false
  }


  disk {
    datastore_id      = "linstor_replicated"
    size              = 128
  }

  # device_passthrough {

  # }

  lifecycle {
    ignore_changes = [node_name, started]
  }
}
