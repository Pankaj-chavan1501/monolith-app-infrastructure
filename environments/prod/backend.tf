terraform {
  backend "azurerm" {
    resource_group_name  = "rg-monolith-tfstate-centralindia-001"
    storage_account_name = "stmonolithtfstateci001"
    container_name       = "tfstate"
    key                  = "monolith/prod/terraform.tfstate"
    use_azuread_auth     = true
  }
}
