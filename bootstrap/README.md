# Terraform Remote State Bootstrap Module

This bootstrap Terraform configuration creates the dedicated Azure infrastructure required for storing Terraform remote state files securely.

## 1. Overview & Decoupled Architecture

> [!IMPORTANT]
> **Decoupled State Rule**: The backend infrastructure created by this bootstrap module MUST NOT be managed by the remote state it hosts. Bootstrap Terraform state remains local to avoid circular dependencies.

### Provisioned Resources

- **Resource Group**: `rg-monolith-tfstate-centralindia-001`
- **Storage Account**: `stmonolithtfstateci001` (Globally unique, Standard LRS)
- **Blob Container**: `tfstate` (Private access)

---

## 2. Security Defaults

- **TLS Version**: Minimum TLS 1.2 (`min_tls_version = "TLS1_2"`)
- **Transport Security**: HTTPS traffic forced
- **Public Access**: Anonymous public blob/container access disabled (`allow_nested_items_to_be_public = false`)
- **Data Protection**:
  - Blob versioning enabled (`versioning_enabled = true`)
  - Blob soft delete enabled (7 days retention)
  - Container soft delete enabled (7 days retention)

---

## 3. Storage Account Naming Standard

Name format: `stmonolithtfstateci001`
- Lowercase alphanumeric characters only
- No hyphens, spaces, or special characters
- Length: 23 characters (within Azure limit of 3-24 characters)

---

## 4. Azure RBAC Prerequisites

The identity executing Terraform commands against the remote backend requires the following Azure Role-Based Access Control (RBAC) permissions:

- **Storage Blob Data Contributor**: Required on the Storage Account or Container level to create, read, write, and lock state blobs using Entra ID authentication (`use_azuread_auth = true`).
- **Contributor**: Required on the Resource Group to manage Azure infrastructure resources.

---

## 5. Bootstrap Execution Instructions

To deploy the remote state backend infrastructure initially:

```bash
cd bootstrap

# Initialize Terraform locally
terraform init

# Review execution plan
terraform plan

# Apply infrastructure changes (creates RG, Storage Account, Container)
terraform apply
```

---

## 6. Outputs

| Name | Description |
| :--- | :--- |
| `resource_group_name` | The name of the Resource Group housing Terraform remote state (`rg-monolith-tfstate-centralindia-001`). |
| `storage_account_name` | The name of the Azure Storage Account (`stmonolithtfstateci001`). |
| `container_name` | The name of the private blob container (`tfstate`). |
