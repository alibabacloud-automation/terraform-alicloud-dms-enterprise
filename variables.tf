# Workspace creation control
variable "create_workspace" {
  description = "Whether to create a new DMS Enterprise workspace. If false, an existing workspace ID must be provided."
  type        = bool
  default     = true
}

# External workspace ID (when create_workspace = false)
variable "workspace_id" {
  description = "The ID of an existing DMS Enterprise workspace. Required when create_workspace is false."
  type        = string
  default     = null
}

# Workspace configuration
variable "workspace_config" {
  description = "The parameters of DMS Enterprise workspace. The attributes 'workspace_name' and 'vpc_id' are required."
  type = object({
    workspace_name = string
    description    = optional(string, "DMS Enterprise workspace created by Terraform")
    vpc_id         = string
  })
}

# Enterprise instance creation control
variable "create_enterprise_instance" {
  description = "Whether to create a new DMS Enterprise instance. If false, an existing instance ID must be provided."
  type        = bool
  default     = true
}

# External enterprise instance ID (when create_enterprise_instance = false)
variable "enterprise_instance_id" {
  description = "The ID of an existing DMS Enterprise instance. Required when create_enterprise_instance is false."
  type        = string
  default     = null
}

# Enterprise instance configuration
variable "enterprise_instance_config" {
  description = "The parameters of DMS Enterprise instance. The attributes 'instance_type', 'instance_source', 'network_type', 'env_type', 'host', 'port', 'database_user', 'database_password', 'dba_uid', 'safe_rule', 'query_timeout', 'export_timeout', 'sell_trust' are required."
  type = object({
    tid               = optional(string, null)
    instance_type     = string
    instance_source   = string
    network_type      = string
    env_type          = string
    host              = string
    port              = number
    database_user     = string
    database_password = string
    instance_name     = optional(string, "DMS Enterprise instance")
    dba_uid           = string
    safe_rule         = string
    query_timeout     = number
    export_timeout    = number
    ecs_region        = optional(string, null)
    use_dsql          = optional(number, 0)
    vpc_id            = optional(string, null)
    ecs_instance_id   = optional(string, null)
    sid               = optional(string, null)
    data_link_name    = optional(string, null)
    ddl_online        = optional(number, 0)
    instance_id       = optional(string, null)
    dba_id            = optional(string, null)
    skip_test         = optional(bool, false)
    safe_rule_id      = optional(string, null)
    sell_trust        = optional(bool, true)
  })
  sensitive = true
}

# Users creation control
variable "create_users" {
  description = "Whether to create DMS Enterprise users."
  type        = bool
  default     = false
}

# Users configuration
variable "users_config" {
  description = "Configuration for DMS Enterprise users."
  type = map(object({
    tid               = optional(string, null)
    uid               = string
    user_name         = optional(string, null)
    role_names        = optional(list(string), ["USER"])
    mobile            = optional(string, null)
    status            = optional(string, "NORMAL")
    max_result_count  = optional(number, null)
    max_execute_count = optional(number, null)
  }))
  default = {}
}

# Authority templates creation control
variable "create_authority_templates" {
  description = "Whether to create DMS Enterprise authority templates."
  type        = bool
  default     = false
}

# Authority templates configuration
variable "authority_templates_config" {
  description = "Configuration for DMS Enterprise authority templates."
  type = map(object({
    tid                     = string
    authority_template_name = string
    description             = optional(string, null)
  }))
  default = {}
}

# Logic databases creation control
variable "create_logic_databases" {
  description = "Whether to create DMS Enterprise logic databases."
  type        = bool
  default     = false
}

# Logic databases configuration
variable "logic_databases_config" {
  description = "Configuration for DMS Enterprise logic databases."
  type = map(object({
    alias        = string
    database_ids = list(string)
  }))
  default = {}
}

# Proxy creation control
variable "create_proxy" {
  description = "Whether to create a DMS Enterprise proxy."
  type        = bool
  default     = false
}

# Proxy configuration
variable "proxy_config" {
  description = "The parameters of DMS Enterprise proxy. The attributes 'username' and 'password' are required."
  type = object({
    username = string
    password = string
    tid      = optional(string, null)
  })
  default   = null
  sensitive = true
}

# Proxy accesses creation control
variable "create_proxy_accesses" {
  description = "Whether to create DMS Enterprise proxy accesses."
  type        = bool
  default     = false
}

# Proxy accesses configuration
variable "proxy_accesses_config" {
  description = "Configuration for DMS Enterprise proxy accesses."
  type = map(object({
    proxy_id       = string
    user_id        = string
    indep_account  = optional(string, null)
    indep_password = optional(string, null)
  }))
  default = {}
}

