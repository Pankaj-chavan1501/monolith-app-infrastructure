variable "workload_name" {
  type        = string
  description = "Name of the workload or application."
  default     = "monolith"

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]{0,30}[a-z0-9])?$", var.workload_name))
    error_message = "workload_name must consist of lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  type        = string
  description = "Azure region location for remote state infrastructure."
  default     = "centralindia"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.location))
    error_message = "location must consist of lowercase letters, numbers, and hyphens."
  }
}

variable "instance" {
  type        = string
  description = "Numeric instance identifier for remote state infrastructure."
  default     = "001"

  validation {
    condition     = can(regex("^[0-9]+$", var.instance))
    error_message = "instance must follow a numeric format."
  }
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique name for the remote state storage account (3-24 lowercase alphanumeric characters)."
  default     = "stmonolithtfstateci001"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "storage_account_name must consist of 3-24 lowercase letters and numbers only, with no spaces or hyphens."
  }
}

variable "container_name" {
  type        = string
  description = "Name of the private blob container for Terraform state."
  default     = "tfstate"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.container_name))
    error_message = "container_name must consist of lowercase letters, numbers, and hyphens."
  }
}

variable "tags" {
  type        = map(string)
  description = "Additional custom tags for remote state infrastructure."
  default     = {}
}
