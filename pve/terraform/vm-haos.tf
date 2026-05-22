resource "proxmox_virtual_environment_vm" "haos_vm" {
  name        = "haos"
  description = "Managed by Terraform"
  tags        = ["haos", "terraform"]

  node_name = "pve-0"
  vm_id     = 1000
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
    cores = 8
    type  = "host" # recommended for modern CPUs
    flags = []
  }

  memory {
    dedicated = 2048
  }

  efi_disk {
    datastore_id = "linstor-repl"
    file_format  = "raw"
    type         = "4m"
  }

  disk {
    datastore_id = "linstor-repl"
    # import_from  = "unraid_backups:import/haos_ova.qcow2"
    file_format = "raw"
    discard     = "on"
    interface   = "scsi0"
    iothread    = false
    ssd         = true
    replicate   = false
    size        = 64
  }

  boot_order = [
    "scsi0"
  ]

  vga {}

  network_device {
    bridge       = "vmbr0"
    mac_address  = "52:54:00:FB:8B:AB"
    disconnected = false
  }

  operating_system {
    type = "l26"
  }

  lifecycle {
    ignore_changes = [
      node_name,
      disk[0].import_from,
    ]
  }
}

resource "proxmox_virtual_environment_haresource" "haos_vm" {
  resource_id  = "vm:${proxmox_virtual_environment_vm.haos_vm.vm_id}"
  state        = "started"
  max_relocate = 1
  max_restart  = 1
  comment      = "Managed by Terraform"
}

# Node Affinity Rule: assign VMs to preferred nodes with priorities.
resource "proxmox_harule" "haos_vm_node_affinity" {
  rule      = "haos-vm-prefer-pve-0"
  type      = "node-affinity"
  comment   = "Prefer pve-0 for HAOS VM"
  resources = ["vm:${proxmox_virtual_environment_vm.haos_vm.vm_id}"]

  nodes = {
    pve-0 = 2 # Higher priority
    pve-1 = 1
    pve-2 = 1
  }

  # Non-strict rules allow failover to other nodes; strict rules do not.
  strict = false
}