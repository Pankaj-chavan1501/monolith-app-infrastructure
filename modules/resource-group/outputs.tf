output "resource_groups" {
  description = "Map of created Azure Resource Group objects."
  value       = azurerm_resource_group.this
}

output "resource_group_names" {
  description = "Map of keys to Resource Group names."
  value       = { for k, v in azurerm_resource_group.this : k => v.name }
}

output "resource_group_locations" {
  description = "Map of keys to Resource Group locations."
  value       = { for k, v in azurerm_resource_group.this : k => v.location }
}
