output "subnets" {
  description = "Map of created Subnet objects."
  value       = azurerm_subnet.this
}

output "subnet_ids" {
  description = "Map of Subnet keys to Subnet IDs."
  value       = { for k, v in azurerm_subnet.this : k => v.id }
}
