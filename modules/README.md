# Reusable Azure Terraform Child Modules

This directory contains enterprise-grade, generic Terraform child modules. Every module accepts a `map` of resource configurations and uses `for_each` to provision Azure resources dynamically.

## Master Modules Summary

| Module Name | Path | Resource Type | Description |
| :--- | :--- | :--- | :--- |
| **Resource Group** | `modules/resource-group` | `azurerm_resource_group` | Provisions Azure Resource Groups using `for_each = var.resource_groups`. |
| **Virtual Network** | `modules/vnet` | `azurerm_virtual_network` | Provisions Azure VNets using `for_each = var.vnets`. |
| **Subnet** | `modules/subnet` | `azurerm_subnet` | Provisions Subnets using `for_each = var.subnets`. |
| **Network Security Group** | `modules/nsg` | `azurerm_network_security_group`<br>`azurerm_network_security_rule` | Provisions NSGs and custom security rules using `for_each = var.nsgs`. |
| **Public IP** | `modules/public-ip` | `azurerm_public_ip` | Provisions Standard SKU Static Public IPs using `for_each = var.public_ips`. |
| **NAT Gateway** | `modules/nat-gateway` | `azurerm_nat_gateway`<br>`azurerm_nat_gateway_public_ip_association`<br>`azurerm_subnet_nat_gateway_association` | Provisions NAT Gateways, Public IP bindings, and Subnet bindings using `for_each`. |
| **Network Interface** | `modules/nic` | `azurerm_network_interface`<br>`azurerm_network_interface_security_group_association` | Provisions NICs with dynamic IP allocations and NSG bindings using `for_each = var.nics`. |

---

## Generic `for_each` & Map Design Standard

All child modules follow the unified map-driven pattern:

```hcl
resource "<azurerm_resource>" "this" {
  for_each = var.<resources_map>

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  # additional attributes passed via map object
}
```

This guarantees clean reusability across all environments (`dev`, `test`, `prod`) with zero code duplication.
