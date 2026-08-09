locals {
  default_tags = {
    ManagedBy = "Terraform"
    Terraform = "true"
  }
}

resource "azurerm_resource_group" "this" {
  for_each = var.resource_groups

  name     = each.value.name
  location = each.value.location
  tags     = merge(local.default_tags, each.value.tags)
}
