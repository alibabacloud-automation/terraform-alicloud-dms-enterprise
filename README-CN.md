阿里云数据管理DMS的Terraform模块

# terraform-alicloud-dms

[English](https://github.com/alibabacloud-automation/terraform-alicloud-dms/blob/main/README.md) | 简体中文

在阿里云上创建DMS（数据管理服务）资源的Terraform模块。该模块为数据库管理提供了全面的解决方案，包括DMS企业版实例、工作空间、用户、权限模板、代理服务和Airflow工作流调度。DMS帮助组织高效管理数据库资源，提供数据库开发、运维和治理的高级功能。有关DMS的更多信息，请参阅[数据管理服务(DMS)](https://www.alibabacloud.com/product/dms)。

## 使用方法

该模块创建具有灵活配置选项的DMS企业版资源。您可以创建完整的DMS设置，或通过配置创建控制变量来使用现有资源。

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

  # 工作空间配置
  create_workspace = true
  workspace_config = {
    workspace_name = "my-dms-workspace"
    description    = "用于数据库管理的DMS工作空间"
    vpc_id         = data.alicloud_vpcs.default.ids[0]
  }

  # 企业版实例配置
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

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-dms/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## 提交问题

如果您在使用此模块时遇到任何问题，请提交一个 [provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 并告知我们。

**注意：** 不建议在此仓库中提交问题。

## 作者

由阿里云 Terraform 团队创建和维护(terraform@alibabacloud.com)。

## 许可证

MIT 许可。有关完整详细信息，请参阅 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)