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


## Notes

- This example creates a complete DMS Enterprise setup with a dedicated VPC and RDS instance
- The RDS instance is configured with MySQL 8.0 and basic security settings
- DMS Enterprise instance is configured for development environment
- Optional features (users, authority templates, proxy) can be enabled by setting the corresponding variables to `true`
- Make sure you have proper permissions to create DMS Enterprise resources in your Alibaba Cloud account