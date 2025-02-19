resource "proxmox_virtual_environment_vm" "games" {
  name        = "games"
  description = "Managed by Terraform"
  tags        = ["terraform", "win11"]

  on_boot = false
  started = false

  node_name = "pve-0"
  vm_id     = 102

  bios = "ovmf"
  machine = "pc-q35-9.0"

  keyboard_layout = "fr"

  operating_system {
    type = "win11"
  }

  tpm_state {
    datastore_id = "linstor_nvme_replicated"
    version = "v2.0"
  }

  agent {
    enabled = true
  }

  scsi_hardware = "virtio-scsi-single"

  cpu {
    cores        = 8
    type         = "host"
  }

  memory {
    dedicated = 16384
    floating  = 4096
  }

  disk {
    size              = 512

    interface         = "scsi0"
    aio               = "io_uring"
    cache             = "none"
    datastore_id      = "linstor_nvme_replicated"
    discard           = "on"
    file_format       = "raw"

    backup            = true
    iothread          = true
    replicate         = true
    ssd               = false
  }

  efi_disk {
    datastore_id      = "linstor_nvme_replicated"
    file_format       = "raw"
    pre_enrolled_keys = true
    type              = "4m"
  }

  hostpci {
    device   = "hostpci0"
    id       = "0000:00:02.3"
    pcie     = false
    rombar   = true
    xvga     = true
  }

  network_device {
    model        = "virtio"
    bridge       = "vmbr0"

    enabled      = true
    firewall     = true
  }

  lifecycle {
    ignore_changes = [audio_device, vga]
  }
}
