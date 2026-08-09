output "resource_group_name" {
  description = "The name of the Resource Group housing Terraform remote state."
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "The name of the Azure Storage Account housing Terraform remote state."
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "The name of the Azure Storage Container housing Terraform remote state blobs."
  value       = azurerm_storage_container.tfstate.name
}
