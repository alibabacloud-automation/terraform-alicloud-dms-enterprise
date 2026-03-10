阿里云DMS企业版的Terraform模块

# terraform-alicloud-dms-enterprise

[English](https://github.com/alibabacloud-automation/terraform-alicloud-dms-enterprise/blob/main/README.md) | 简体中文

在阿里云上创建DMS（数据管理服务）资源的Terraform模块。该模块为数据库管理提供了全面的解决方案，包括DMS企业版实例、工作空间、用户、权限模板、代理服务和Airflow工作流调度。DMS帮助组织高效管理[数据库资源开发、运维和治理](https://www.alibabacloud.com/help/zh/data-management-service/)的高级功能。

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
  source = "alibabacloud-automation/dms-enterprise/alicloud"

  # 工作空间配置
  workspace_config = {
    workspace_name = "my-dms-workspace"
    description    = "用于数据库管理的DMS工作空间"
    vpc_id         = data.alicloud_vpcs.default.ids[0]
  }

  # 企业版实例配置
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
  }
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-dms-enterprise/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.212.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.212.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_dms_enterprise_authority_template.authority_templates](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_authority_template) | resource |
| [alicloud_dms_enterprise_instance.instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_instance) | resource |
| [alicloud_dms_enterprise_logic_database.logic_databases](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_logic_database) | resource |
| [alicloud_dms_enterprise_proxy.proxy](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_proxy) | resource |
| [alicloud_dms_enterprise_proxy_access.proxy_accesses](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_proxy_access) | resource |
| [alicloud_dms_enterprise_user.users](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_user) | resource |
| [alicloud_dms_enterprise_workspace.workspace](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/dms_enterprise_workspace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authority_templates_config"></a> [authority\_templates\_config](#input\_authority\_templates\_config) | Configuration for DMS Enterprise authority templates. | <pre>map(object({<br/>    tid                     = string<br/>    authority_template_name = string<br/>    description             = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_create_authority_templates"></a> [create\_authority\_templates](#input\_create\_authority\_templates) | Whether to create DMS Enterprise authority templates. | `bool` | `false` | no |
| <a name="input_create_enterprise_instance"></a> [create\_enterprise\_instance](#input\_create\_enterprise\_instance) | Whether to create a new DMS Enterprise instance. If false, an existing instance ID must be provided. | `bool` | `true` | no |
| <a name="input_create_logic_databases"></a> [create\_logic\_databases](#input\_create\_logic\_databases) | Whether to create DMS Enterprise logic databases. | `bool` | `false` | no |
| <a name="input_create_proxy"></a> [create\_proxy](#input\_create\_proxy) | Whether to create a DMS Enterprise proxy. | `bool` | `false` | no |
| <a name="input_create_proxy_accesses"></a> [create\_proxy\_accesses](#input\_create\_proxy\_accesses) | Whether to create DMS Enterprise proxy accesses. | `bool` | `false` | no |
| <a name="input_create_users"></a> [create\_users](#input\_create\_users) | Whether to create DMS Enterprise users. | `bool` | `false` | no |
| <a name="input_create_workspace"></a> [create\_workspace](#input\_create\_workspace) | Whether to create a new DMS Enterprise workspace. If false, an existing workspace ID must be provided. | `bool` | `true` | no |
| <a name="input_enterprise_instance_config"></a> [enterprise\_instance\_config](#input\_enterprise\_instance\_config) | The parameters of DMS Enterprise instance. The attributes 'instance\_type', 'instance\_source', 'network\_type', 'env\_type', 'host', 'port', 'database\_user', 'database\_password', 'dba\_uid', 'safe\_rule', 'query\_timeout', 'export\_timeout', 'sell\_trust' are required. | <pre>object({<br/>    tid               = optional(string, null)<br/>    instance_type     = string<br/>    instance_source   = string<br/>    network_type      = string<br/>    env_type          = string<br/>    host              = string<br/>    port              = number<br/>    database_user     = string<br/>    database_password = string<br/>    instance_name     = optional(string, "DMS Enterprise instance")<br/>    dba_uid           = string<br/>    safe_rule         = string<br/>    query_timeout     = number<br/>    export_timeout    = number<br/>    ecs_region        = optional(string, null)<br/>    use_dsql          = optional(number, 0)<br/>    vpc_id            = optional(string, null)<br/>    ecs_instance_id   = optional(string, null)<br/>    sid               = optional(string, null)<br/>    data_link_name    = optional(string, null)<br/>    ddl_online        = optional(number, 0)<br/>    instance_id       = optional(string, null)<br/>    dba_id            = optional(string, null)<br/>    skip_test         = optional(bool, false)<br/>    safe_rule_id      = optional(string, null)<br/>    sell_trust        = optional(bool, true)<br/>  })</pre> | n/a | yes |
| <a name="input_enterprise_instance_id"></a> [enterprise\_instance\_id](#input\_enterprise\_instance\_id) | The ID of an existing DMS Enterprise instance. Required when create\_enterprise\_instance is false. | `string` | `null` | no |
| <a name="input_logic_databases_config"></a> [logic\_databases\_config](#input\_logic\_databases\_config) | Configuration for DMS Enterprise logic databases. | <pre>map(object({<br/>    alias        = string<br/>    database_ids = list(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_proxy_accesses_config"></a> [proxy\_accesses\_config](#input\_proxy\_accesses\_config) | Configuration for DMS Enterprise proxy accesses. | <pre>map(object({<br/>    proxy_id       = string<br/>    user_id        = string<br/>    indep_account  = optional(string, null)<br/>    indep_password = optional(string, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_proxy_config"></a> [proxy\_config](#input\_proxy\_config) | The parameters of DMS Enterprise proxy. The attributes 'username' and 'password' are required. | <pre>object({<br/>    username = string<br/>    password = string<br/>    tid      = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_users_config"></a> [users\_config](#input\_users\_config) | Configuration for DMS Enterprise users. | <pre>map(object({<br/>    tid               = optional(string, null)<br/>    uid               = string<br/>    user_name         = optional(string, null)<br/>    role_names        = optional(list(string), ["USER"])<br/>    mobile            = optional(string, null)<br/>    status            = optional(string, "NORMAL")<br/>    max_result_count  = optional(number, null)<br/>    max_execute_count = optional(number, null)<br/>  }))</pre> | `{}` | no |
| <a name="input_workspace_config"></a> [workspace\_config](#input\_workspace\_config) | The parameters of DMS Enterprise workspace. The attributes 'workspace\_name' and 'vpc\_id' are required. | <pre>object({<br/>    workspace_name = string<br/>    description    = optional(string, "DMS Enterprise workspace created by Terraform")<br/>    vpc_id         = string<br/>  })</pre> | n/a | yes |
| <a name="input_workspace_id"></a> [workspace\_id](#input\_workspace\_id) | The ID of an existing DMS Enterprise workspace. Required when create\_workspace is false. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_authority_templates_create_times"></a> [authority\_templates\_create\_times](#output\_authority\_templates\_create\_times) | The creation times of the DMS Enterprise authority templates |
| <a name="output_authority_templates_ids"></a> [authority\_templates\_ids](#output\_authority\_templates\_ids) | The IDs of the DMS Enterprise authority templates |
| <a name="output_enterprise_instance_dba_nick_name"></a> [enterprise\_instance\_dba\_nick\_name](#output\_enterprise\_instance\_dba\_nick\_name) | The DBA nickname of the DMS Enterprise instance |
| <a name="output_enterprise_instance_id"></a> [enterprise\_instance\_id](#output\_enterprise\_instance\_id) | The ID of the DMS Enterprise instance |
| <a name="output_enterprise_instance_status"></a> [enterprise\_instance\_status](#output\_enterprise\_instance\_status) | The status of the DMS Enterprise instance |
| <a name="output_logic_databases_ids"></a> [logic\_databases\_ids](#output\_logic\_databases\_ids) | The IDs of the DMS Enterprise logic databases |
| <a name="output_logic_databases_schema_names"></a> [logic\_databases\_schema\_names](#output\_logic\_databases\_schema\_names) | The schema names of the DMS Enterprise logic databases |
| <a name="output_logic_databases_search_names"></a> [logic\_databases\_search\_names](#output\_logic\_databases\_search\_names) | The search names of the DMS Enterprise logic databases |
| <a name="output_proxy_accesses_access_ids"></a> [proxy\_accesses\_access\_ids](#output\_proxy\_accesses\_access\_ids) | The access IDs of the DMS Enterprise proxy accesses |
| <a name="output_proxy_accesses_ids"></a> [proxy\_accesses\_ids](#output\_proxy\_accesses\_ids) | The IDs of the DMS Enterprise proxy accesses |
| <a name="output_proxy_id"></a> [proxy\_id](#output\_proxy\_id) | The ID of the DMS Enterprise proxy |
| <a name="output_users_ids"></a> [users\_ids](#output\_users\_ids) | The IDs of the DMS Enterprise users |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | The ID of the DMS Enterprise workspace |
| <a name="output_workspace_region_id"></a> [workspace\_region\_id](#output\_workspace\_region\_id) | The region ID of the DMS Enterprise workspace |
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