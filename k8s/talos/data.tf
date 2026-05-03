data "talos_image_factory_urls" "this" {
  talos_version = local.talos_version
  schematic_id  = talos_image_factory_schematic.this.id

  platform      = "nocloud"
  architecture  = "amd64"
}
