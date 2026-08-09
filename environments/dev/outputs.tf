output "resource_group_id" {
  description = "The ID of the Azure Resource Group."
  value       = module.resource_group.resource_group_id
}

output "resource_group_name" {
  description = "The name of the Azure Resource Group."
  value       = module.resource_group.resource_group_name
}

output "resource_group_location" {
  description = "The Azure region location of the Resource Group."
  value       = module.resource_group.resource_group_location
}
