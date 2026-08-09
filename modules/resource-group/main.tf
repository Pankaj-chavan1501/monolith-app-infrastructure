terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

locals {
  resource_group_name = "rg-${var.workload_name}-${var.environment}-${var.location}-${var.instance}"

  default_tags = {
    Environment = var.environment
    Workload    = var.workload_name
    ManagedBy   = "Terraform"
    Terraform   = "true"
  }
}

resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location

  tags = merge(local.default_tags, var.tags)
}
