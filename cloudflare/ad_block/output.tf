output "number_of_ads_lists" {
  value = length(local.capped_ads_lists)
}

output "number_of_padding_lists" {
  value = length(local.padding)
}