output "resource_group_names" {
  description = "Map of created Resource Group names."
  value       = module.resource_group.resource_group_names
}

output "vnet_ids" {
  description = "Map of created Virtual Network IDs."
  value       = module.vnet.vnet_ids
}

output "subnet_ids" {
  description = "Map of created Subnet IDs."
  value       = module.subnet.subnet_ids
}

output "nsg_ids" {
  description = "Map of created Network Security Group IDs."
  value       = module.nsg.nsg_ids
}

output "public_ip_ids" {
  description = "Map of Public IP IDs allocated for NAT Gateways."
  value       = module.nat_public_ip.public_ip_ids
}

output "public_ip_addresses" {
  description = "Map of Public IP addresses allocated for NAT Gateways."
  value       = module.nat_public_ip.public_ip_addresses
}

output "nat_gateway_ids" {
  description = "Map of created NAT Gateway IDs."
  value       = module.nat_gateway.nat_gateway_ids
}

output "nic_ids" {
  description = "Map of created Network Interface IDs."
  value       = module.nic.nic_ids
}
