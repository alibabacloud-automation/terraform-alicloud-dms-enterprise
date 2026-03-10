# DMS Enterprise Workspace outputs
output "workspace_id" {
  description = "The ID of the DMS Enterprise workspace"
  value       = var.create_workspace ? alicloud_dms_enterprise_workspace.workspace[0].id : var.workspace_id
}

output "workspace_region_id" {
  description = "The region ID of the DMS Enterprise workspace"
  value       = var.create_workspace ? alicloud_dms_enterprise_workspace.workspace[0].region_id : null
}

# DMS Enterprise Instance outputs
output "enterprise_instance_id" {
  description = "The ID of the DMS Enterprise instance"
  value       = var.create_enterprise_instance ? alicloud_dms_enterprise_instance.instance[0].id : var.enterprise_instance_id
}

output "enterprise_instance_dba_nick_name" {
  description = "The DBA nickname of the DMS Enterprise instance"
  value       = var.create_enterprise_instance ? alicloud_dms_enterprise_instance.instance[0].dba_nick_name : null
}

output "enterprise_instance_status" {
  description = "The status of the DMS Enterprise instance"
  value       = var.create_enterprise_instance ? alicloud_dms_enterprise_instance.instance[0].status : null
}

# DMS Enterprise Users outputs
output "users_ids" {
  description = "The IDs of the DMS Enterprise users"
  value       = var.create_users ? { for k, v in alicloud_dms_enterprise_user.users : k => v.id } : {}
}

# DMS Enterprise Authority Templates outputs
output "authority_templates_ids" {
  description = "The IDs of the DMS Enterprise authority templates"
  value       = var.create_authority_templates ? { for k, v in alicloud_dms_enterprise_authority_template.authority_templates : k => v.id } : {}
}

output "authority_templates_create_times" {
  description = "The creation times of the DMS Enterprise authority templates"
  value       = var.create_authority_templates ? { for k, v in alicloud_dms_enterprise_authority_template.authority_templates : k => v.create_time } : {}
}

# DMS Enterprise Logic Databases outputs
output "logic_databases_ids" {
  description = "The IDs of the DMS Enterprise logic databases"
  value       = var.create_logic_databases ? { for k, v in alicloud_dms_enterprise_logic_database.logic_databases : k => v.id } : {}
}

output "logic_databases_schema_names" {
  description = "The schema names of the DMS Enterprise logic databases"
  value       = var.create_logic_databases ? { for k, v in alicloud_dms_enterprise_logic_database.logic_databases : k => v.schema_name } : {}
}

output "logic_databases_search_names" {
  description = "The search names of the DMS Enterprise logic databases"
  value       = var.create_logic_databases ? { for k, v in alicloud_dms_enterprise_logic_database.logic_databases : k => v.search_name } : {}
}

# DMS Enterprise Proxy outputs
output "proxy_id" {
  description = "The ID of the DMS Enterprise proxy"
  value       = var.create_proxy ? alicloud_dms_enterprise_proxy.proxy[0].id : null
}

# DMS Enterprise Proxy Access outputs
output "proxy_accesses_ids" {
  description = "The IDs of the DMS Enterprise proxy accesses"
  value       = var.create_proxy_accesses ? { for k, v in alicloud_dms_enterprise_proxy_access.proxy_accesses : k => v.id } : {}
}

output "proxy_accesses_access_ids" {
  description = "The access IDs of the DMS Enterprise proxy accesses"
  value       = var.create_proxy_accesses ? { for k, v in alicloud_dms_enterprise_proxy_access.proxy_accesses : k => v.access_id } : {}
}

