# Complete Example

This example demonstrates the complete usage of the Terraform Alicloud DMS module.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| alicloud | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| alicloud | >= 1.212.0 |

## Resources Created

This example creates the following resources:

- VPC and VSwitch for DMS workspace
- Security Group for network access control
- RDS MySQL instance for DMS Enterprise instance
- DB account for database access
- DMS Enterprise workspace
- DMS Enterprise instance
- Optional: DMS Enterprise users, authority templates, and proxy

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The region where to deploy the resources | `string` | `"cn-hangzhou"` | no |
| zone_id | The zone ID where to deploy the resources | `string` | `"cn-hangzhou-h"` | no |
| name | The name prefix for all resources | `string` | `"terraform-dms-example"` | no |
| create_users | Whether to create DMS Enterprise users in the example | `bool` | `false` | no |
| create_authority_templates | Whether to create DMS Enterprise authority templates in the example | `bool` | `false` | no |
| create_proxy | Whether to create DMS Enterprise proxy in the example | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| workspace_id | The ID of the DMS Enterprise workspace |
| enterprise_instance_id | The ID of the DMS Enterprise instance |
| users_ids | The IDs of the DMS Enterprise users |
| authority_templates_ids | The IDs of the DMS Enterprise authority templates |
| proxy_id | The ID of the DMS Enterprise proxy |
| vpc_id | The ID of the VPC |
| vswitch_id | The ID of the VSwitch |
| db_instance_id | The ID of the RDS instance |
| db_connection_string | The connection string of the RDS instance |

## Notes

- This example creates a complete DMS Enterprise setup with a dedicated VPC and RDS instance
- The RDS instance is configured with MySQL 8.0 and basic security settings
- DMS Enterprise instance is configured for development environment
- Optional features (users, authority templates, proxy) can be enabled by setting the corresponding variables to `true`
- Make sure you have proper permissions to create DMS Enterprise resources in your Alibaba Cloud account