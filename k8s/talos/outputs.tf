output "schematic_id" {
  value = talos_image_factory_schematic.this.id
}

output "installer_image_url" {
  value = data.talos_image_factory_urls.this.urls.installer
}

output "machine_config_hashes" {
  value = { for node_name, config in talos_machine_configuration_apply.controlplane : node_name => config.machine_configuration_hash }
}
