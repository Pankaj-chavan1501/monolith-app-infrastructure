# Azure Resource Group Module

This reusable child Terraform module creates an Azure Resource Group (`azurerm_resource_group.this`) following enterprise naming standards and automated tagging strategies.

## Module Purpose

Provides a standardized, environment-agnostic child module to manage Azure Resource Group creation across enterprise environments (`dev`, `test`, `prod`).

## Child Module Responsibility

- Enforces the enterprise naming convention: `rg-<workload>-<environment>-<region>-<instance>`
- Standardizes default metadata tags (`Environment`, `Workload`, `ManagedBy`, `Terraform`)
- Accepts and merges custom workload tags (`var.tags`)
- Validates all input arguments (naming syntax, allowed environments, location format, numeric instance format)
- Exposes Resource Group outputs (`resource_group_id`, `resource_group_name`, `resource_group_location`)

## Inputs

| Name | Type | Default | Description | Required |
| :--- | :--- | :--- | :--- | :---: |
| `workload_name` | `string` | n/a | Name of the workload or application (lowercase, alphanumeric, hyphens). | yes |
| `environment` | `string` | n/a | Deployment target environment (`dev`, `test`, `prod`). | yes |
| `location` | `string` | n/a | Target Azure region location (e.g., `centralindia`). | yes |
| `instance` | `string` | n/a | Numeric instance identifier (e.g., `001`). | yes |
| `tags` | `map(string)` | `{}` | Additional custom tags to merge with default tags. | no |

## Outputs

| Name | Description |
| :--- | :--- |
| `resource_group_id` | The ID of the created Azure Resource Group. |
| `resource_group_name` | The name of the created Azure Resource Group. |
| `resource_group_location` | The Azure region location of the created Azure Resource Group. |

## Naming Convention

The module dynamically constructs the Resource Group name using local values:

```hcl
local.resource_group_name = "rg-${var.workload_name}-${var.environment}-${var.location}-${var.instance}"
```

**Pattern:** `rg-<workload>-<environment>-<region>-<instance>`  
**Example:** `rg-monolith-dev-centralindia-001`

## Tagging Strategy

Default tags applied automatically:
- `Environment` = `var.environment`
- `Workload`    = `var.workload_name`
- `ManagedBy`   = `"Terraform"`
- `Terraform`   = `"true"`

Custom tags passed in `var.tags` are merged with the default tags using Terraform's `merge()` function.

## Example Usage

```hcl
module "resource_group" {
  source = "../../modules/resource-group"

  workload_name = "monolith"
  environment   = "dev"
  location      = "centralindia"
  instance      = "001"

  tags = {
    CostCenter = "CC-1234"
  }
}
```

## Security Considerations

- Does **not** contain authentication credentials, subscription IDs, or tenant IDs.
- Provider configuration is excluded from this child module and must be defined in the parent root module.
- Tags must not contain secrets or sensitive enterprise data.
