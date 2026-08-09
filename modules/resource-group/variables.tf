variable "workload_name" {
  type        = string
  description = "Name of the workload or application (lowercase, alphanumeric and hyphens)."

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]{0,30}[a-z0-9])?$", var.workload_name))
    error_message = "workload_name must consist of lowercase letters, numbers, and hyphens, cannot start or end with a hyphen, and must be between 1 and 32 characters."
  }
}

variable "environment" {
  type        = string
  description = "Target environment (dev, test, prod)."

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, prod."
  }
}

variable "location" {
  type        = string
  description = "Azure region location (lowercase, alphanumeric and hyphens)."

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.location))
    error_message = "location must consist of lowercase letters, numbers, and hyphens without spaces."
  }
}

variable "instance" {
  type        = string
  description = "Resource instance number identifier (numeric format, e.g., 001)."

  validation {
    condition     = can(regex("^[0-9]+$", var.instance))
    error_message = "instance must follow a numeric format (e.g., '001')."
  }
}

variable "tags" {
  type        = map(string)
  description = "Additional custom tags to append to the default resource group tags."
  default     = {}
}
