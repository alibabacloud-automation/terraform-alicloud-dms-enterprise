
# DMS Enterprise Workspace (foundational resource)
resource "alicloud_dms_enterprise_workspace" "workspace" {
  count          = var.create_workspace ? 1 : 0
  workspace_name = var.workspace_config.workspace_name
  description    = var.workspace_config.description
  vpc_id         = var.workspace_config.vpc_id
}

# DMS Enterprise Instance (core database instance)
resource "alicloud_dms_enterprise_instance" "instance" {
  count             = var.create_enterprise_instance ? 1 : 0
  tid               = var.enterprise_instance_config.tid
  instance_type     = var.enterprise_instance_config.instance_type
  instance_source   = var.enterprise_instance_config.instance_source
  network_type      = var.enterprise_instance_config.network_type
  env_type          = var.enterprise_instance_config.env_type
  host              = var.enterprise_instance_config.host
  port              = var.enterprise_instance_config.port
  database_user     = var.enterprise_instance_config.database_user
  database_password = var.enterprise_instance_config.database_password
  instance_name     = var.enterprise_instance_config.instance_name
  dba_uid           = var.enterprise_instance_config.dba_uid
  safe_rule         = var.enterprise_instance_config.safe_rule
  query_timeout     = var.enterprise_instance_config.query_timeout
  export_timeout    = var.enterprise_instance_config.export_timeout
  ecs_region        = var.enterprise_instance_config.ecs_region
  use_dsql          = var.enterprise_instance_config.use_dsql
  vpc_id            = var.enterprise_instance_config.vpc_id
  ecs_instance_id   = var.enterprise_instance_config.ecs_instance_id
  sid               = var.enterprise_instance_config.sid
  data_link_name    = var.enterprise_instance_config.data_link_name
  ddl_online        = var.enterprise_instance_config.ddl_online
  instance_id       = var.enterprise_instance_config.instance_id
  dba_id            = var.enterprise_instance_config.dba_id
  skip_test         = var.enterprise_instance_config.skip_test
  safe_rule_id      = var.enterprise_instance_config.safe_rule_id
  sell_trust        = var.enterprise_instance_config.sell_trust
}

# DMS Enterprise User (user management)
resource "alicloud_dms_enterprise_user" "users" {
  for_each          = var.create_users ? var.users_config : {}
  tid               = each.value.tid
  uid               = each.value.uid
  user_name         = each.value.user_name
  role_names        = each.value.role_names
  mobile            = each.value.mobile
  status            = each.value.status
  max_result_count  = each.value.max_result_count
  max_execute_count = each.value.max_execute_count
}

# DMS Enterprise Authority Template (permission template)
resource "alicloud_dms_enterprise_authority_template" "authority_templates" {
  for_each                = var.create_authority_templates ? var.authority_templates_config : {}
  tid                     = each.value.tid
  authority_template_name = each.value.authority_template_name
  description             = each.value.description
}

# DMS Enterprise Logic Database (logical database)
resource "alicloud_dms_enterprise_logic_database" "logic_databases" {
  for_each     = var.create_logic_databases ? var.logic_databases_config : {}
  alias        = each.value.alias
  database_ids = each.value.database_ids
}

# DMS Enterprise Proxy (database proxy)
resource "alicloud_dms_enterprise_proxy" "proxy" {
  count       = var.create_proxy ? 1 : 0
  instance_id = var.create_enterprise_instance ? alicloud_dms_enterprise_instance.instance[0].id : var.enterprise_instance_id
  username    = var.proxy_config.username
  password    = var.proxy_config.password
  tid         = var.proxy_config.tid
}

# DMS Enterprise Proxy Access (proxy access control)
resource "alicloud_dms_enterprise_proxy_access" "proxy_accesses" {
  for_each       = var.create_proxy_accesses ? var.proxy_accesses_config : {}
  proxy_id       = var.create_proxy ? alicloud_dms_enterprise_proxy.proxy[0].id : each.value.proxy_id
  user_id        = each.value.user_id
  indep_account  = each.value.indep_account
  indep_password = each.value.indep_password
}

