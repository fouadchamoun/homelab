resource "proxmox_virtual_environment_vm" "talos_vm" {
  count = 3

  name        = format("talos-vm-%02d", count.index)
  description = "Managed by Terraform"
  tags        = ["talos", "terraform"]

  node_name = "pve-${count.index}"
  vm_id     = 4000 + count.index
  started   = true

  machine         = "q35"
  bios            = "ovmf"
  on_boot         = true
  protection      = false
  keyboard_layout = "fr"
  tablet_device   = false

  agent {
    enabled = true
    trim    = true
  }

  cpu {
    cores = 16
    type  = "host" # recommended for modern CPUs
    flags = []
  }

  memory {
    dedicated = 12288
  }

  efi_disk {
    datastore_id = "linstor-repl"
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "linstor-repl"
    file_format  = "raw"
    discard      = "on"
    interface    = "scsi0"
    iothread     = true
    ssd          = true
    replicate    = false
    size         = 100
  }

  cdrom {
    interface = "ide0"
    file_id   = "none"
    # file_id   = data.proxmox_virtual_environment_file.talos_iso.id
  }

  boot_order = [
    "scsi0",
    "ide0",
  ]

  network_device {
    bridge       = "vmbr0"
    disconnected = false
  }

  operating_system {
    type = "l26"
  }
}

data "proxmox_virtual_environment_file" "talos_iso" {
  node_name    = "pve-0"
  datastore_id = "unraid_isos"
  content_type = "iso"
  file_name    = "nocloud-amd64.iso"
}
