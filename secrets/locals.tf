locals {
  secret_keys_set = setsubtract(
    toset(keys(yamldecode(file("secrets.sops.yaml")))),
    toset(["sops"])
  )
}
