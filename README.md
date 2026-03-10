Terraform Module for Alibaba Cloud DMS (Data Management Service)

# terraform-alicloud-dms

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-dms/blob/main/README-CN.md)

Terraform module which creates DMS (Data Management Service) resources on Alibaba Cloud. This module provides a comprehensive solution for database management, including DMS Enterprise instances, workspaces, users, authority templates, proxy services, and Airflow workflow scheduling. DMS helps organizations efficiently manage their database resources with advanced features for database development, operation, and governance. For more information about DMS, see [Data Management Service (DMS)](https://www.alibabacloud.com/product/dms).

## Usage

This module creates DMS Enterprise resources with flexible configuration options. You can create a complete DMS setup or use existing resources by configuring the creation control variables.

```terraform
data "alicloud_dms_user_tenants" "default" {
  status = "ACTIVE"
}

data "alicloud_account" "current" {}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

module "dms" {
  source = "alibabacloud-automation/dms/alicloud"

  # Workspace configuration
  create_workspace = true
  workspace_config = {
    workspace_name = "my-dms-workspace"
    description    = "DMS workspace for database management"
    vpc_id         = data.alicloud_vpcs.default.ids[0]
  }

  # Enterprise instance configuration
  create_enterprise_instance = true
  enterprise_instance_config = {
    tid               = data.alicloud_dms_user_tenants.default.ids[0]
    instance_type     = "mysql"
    instance_source   = "RDS"
    network_type      = "VPC"
    env_type          = "dev"
    host              = "your-rds-host.mysql.rds.aliyuncs.com"
    port              = 3306
    database_user     = "your_db_user"
    database_password = "your_db_password"
    instance_name     = "my-dms-instance"
    dba_uid           = data.alicloud_account.current.id
    safe_rule         = "904496"
    query_timeout     = 60
    export_timeout    = 600
    ecs_region        = "cn-hangzhou"
    use_dsql          = 1
  }
}
```

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-dms/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems when using this module, please opening
a [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend opening an issue on this repo.

## Authors

Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com).

## License

MIT Licensed. See LICENSE for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)