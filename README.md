# Enterprise Azure Monolithic Application Infrastructure

Production-ready, modular Terraform infrastructure project for managing Azure resources supporting enterprise application workloads.

## 1. Project Purpose

This repository manages enterprise Azure cloud resources using modern Terraform standard practices. It enforces strict separation of environments (`dev`, `test`, `prod`), standard enterprise naming conventions, default metadata tagging, and automated security scanning.

## 2. Architecture Overview

The infrastructure uses a modular, scalable Parent/Child architecture:

- **Parent/Root Modules**: Located under `environments/{dev,test,prod}/`, responsible for environment isolation, provider configuration, and passing inputs.
- **Child Modules**: Located under `modules/`, encapsulating reusable, environment-agnostic Azure resource definitions.

```
monolith-app-infrastructure/
│
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── terraform.tfvars.example
│   │
│   ├── test/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── providers.tf
│   │   └── terraform.tfvars.example
│   │
│   └── prod/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── providers.tf
│       └── terraform.tfvars.example
│
├── modules/
│   └── resource-group/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
│
├── .gitignore
└── README.md
```

## 3. Parent / Child Module Design

All environment parent modules reuse the identical child module located at `modules/resource-group/`.

```
environments/dev  -----\
environments/test ------>  modules/resource-group
environments/prod -----/
```

- **Child Module (`modules/resource-group`)**: Contains the single `azurerm_resource_group.this` Terraform resource definition.
- Environment directories call this module using `source = "../../modules/resource-group"`.
- Resource definitions are **never** duplicated across environments.

## 4. Resource Group Naming Convention

Azure Resource Groups follow the standardized enterprise pattern:

$$\text{rg-} \langle \text{workload} \rangle \text{-} \langle \text{environment} \rangle \text{-} \langle \text{region} \rangle \text{-} \langle \text{instance} \rangle$$

Implemented dynamically in `modules/resource-group/main.tf`:

```hcl
local.resource_group_name = "rg-${var.workload_name}-${var.environment}-${var.location}-${var.instance}"
```

### Resource Group Name Examples

- **Development**: `rg-monolith-dev-centralindia-001`
- **Testing**: `rg-monolith-test-centralindia-001`
- **Production**: `rg-monolith-prod-centralindia-001`

## 5. Enterprise Tagging Strategy

Every resource deployed receives standard enterprise tags merged with custom environment tags:

- `Environment`: Environment name (`dev`, `test`, `prod`)
- `Workload`: Application workload identifier (`monolith`)
- `ManagedBy`: Infrastructure management tool (`Terraform`)
- `Terraform`: Execution flag (`true`)

Custom workload tags passed via `var.tags` are merged via `merge(local.default_tags, var.tags)`. No secret credentials or sensitive operational data are stored in resource tags.

## 6. Current Implemented Scope

In this phase, **only Azure Resource Groups** are implemented:
- Child module: `azurerm_resource_group.this`
- Target environments: `dev`, `test`, `prod`

*Note: Networking (VNets/subnets), compute (VMs/NICs), storage, Key Vaults, monitoring, and load balancers are intentionally out of scope for this phase.*

## 7. Terraform Usage & Execution

### Prerequisites

- Terraform `v1.5.0` or higher
- AzureRM Provider `~> 4.0`

### Local Development / Validation

To validate an environment locally:

```bash
# Change to target environment directory
cd environments/dev

# Copy example variables
cp terraform.tfvars.example terraform.tfvars

# Initialize Terraform (without remote backend)
terraform init -backend=false

# Validate configuration
terraform validate
```

## 8. Validation & Security Scanning

The codebase undergoes formatting, syntax validation, linting, and secret detection:

1. **Formatting**: `terraform fmt -check -recursive`
2. **Syntax Validation**: `terraform validate` per environment
3. **Linting**: `tflint --recursive`
4. **Secret Scanning**: `gitleaks detect`

## 9. Future Infrastructure Phases & Remote Backend

### State Isolation Plan
To maintain enterprise safety, state isolation is strictly maintained per environment:
- `environments/dev/terraform.tfstate`
- `environments/test/terraform.tfstate`
- `environments/prod/terraform.tfstate`

### Remote Backend Setup (Future Phase)
Remote backend configuration using Azure Storage Account Blob Containers (`azurerm` backend) will be added in a future deployment phase. Dedicated backend storage accounts and containers will be configured per environment with state locking.

### Planned Modules
- Network Infrastructure (VNet, Subnets, Network Security Groups)
- Compute & Storage (Virtual Machines, Network Interfaces, Storage Accounts)
- Security & Key Management (Azure Key Vault, Role-Based Access Control)
- Operational Intelligence (Log Analytics Workspace, Azure Monitor)
- Continuous Integration & Deployment (GitHub Actions Workflows)
