variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
  description = "Map of Azure Resource Groups to provision."
}

variable "vnets" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string), {})
  }))
  description = "Map of Virtual Networks to provision."
}

variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
  description = "Map of Subnets to provision."
}

variable "nsgs" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = optional(map(string), {})
    security_rules = optional(map(object({
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string, "*")
      destination_port_range     = optional(string, "*")
      source_address_prefix      = optional(string, "*")
      destination_address_prefix = optional(string, "*")
      description                = optional(string, "")
    })), {})
  }))
  description = "Map of Network Security Groups and security rules to provision."
}

variable "public_ips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = optional(string, "Static")
    sku                 = optional(string, "Standard")
    tags                = optional(map(string), {})
  }))
  description = "Map of Public IPs to provision."
}

variable "nat_gateways" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    public_ip_key       = string
    subnet_keys         = list(string)
    sku_name            = optional(string, "Standard")
    tags                = optional(map(string), {})
  }))
  description = "Map of NAT Gateways to provision."
}

variable "nics" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    subnet_key                    = string
    nsg_key                       = optional(string, null)
    associate_nsg                 = optional(bool, true)
    private_ip_address_allocation = optional(string, "Dynamic")
    tags                          = optional(map(string), {})
  }))
  description = "Map of Network Interfaces to provision."
}
