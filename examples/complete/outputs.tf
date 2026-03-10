# Module outputs
output "workspace_id" {
  description = "The ID of the DMS Enterprise workspace"
  value       = module.dms.workspace_id
}

output "enterprise_instance_id" {
  description = "The ID of the DMS Enterprise instance"
  value       = module.dms.enterprise_instance_id
}

output "users_ids" {
  description = "The IDs of the DMS Enterprise users"
  value       = module.dms.users_ids
}

output "authority_templates_ids" {
  description = "The IDs of the DMS Enterprise authority templates"
  value       = module.dms.authority_templates_ids
}

output "proxy_id" {
  description = "The ID of the DMS Enterprise proxy"
  value       = module.dms.proxy_id
}

# Infrastructure outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.example.id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.example.id
}

output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = alicloud_db_instance.example.id
}

output "db_connection_string" {
  description = "The connection string of the RDS instance"
  value       = alicloud_db_instance.example.connection_string
}