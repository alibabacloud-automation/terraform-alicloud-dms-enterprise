provider "alicloud" {
  region = var.region
}

# Data sources to get existing resources
data "alicloud_dms_user_tenants" "default" {
  status = "ACTIVE"
}

data "alicloud_account" "current" {}

data "alicloud_regions" "default" {
  current = true
}

data "alicloud_db_zones" "default" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  instance_charge_type     = "PostPaid"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
}

data "alicloud_db_instance_classes" "default" {
  zone_id                  = data.alicloud_db_zones.default.zones[0].id
  engine                   = "MySQL"
  engine_version           = "8.0"
  category                 = "HighAvailability"
  db_instance_storage_type = "cloud_essd"
  instance_charge_type     = "PostPaid"
}

# Create a VPC for DMS workspace
resource "alicloud_vpc" "example" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "example" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.example.id
  zone_id      = var.zone_id != null ? var.zone_id : data.alicloud_db_zones.default.zones[0].id
}

resource "alicloud_security_group" "example" {
  security_group_name = var.name
  vpc_id              = alicloud_vpc.example.id
}

# Create a RDS instance for DMS Enterprise
resource "alicloud_db_instance" "example" {
  engine                   = "MySQL"
  engine_version           = "8.0"
  db_instance_storage_type = "cloud_essd"
  instance_type            = data.alicloud_db_instance_classes.default.instance_classes[0].instance_class
  instance_storage         = data.alicloud_db_instance_classes.default.instance_classes[0].storage_range.min
  vswitch_id               = alicloud_vswitch.example.id
  instance_name            = var.name
  security_ips             = ["100.104.5.0/24", "192.168.0.6"]
}

resource "alicloud_db_account" "example" {
  db_instance_id   = alicloud_db_instance.example.id
  account_name     = "testuser"
  account_password = "Test123456"
  account_type     = "Normal"
}

# Use the DMS module
module "dms" {
  source = "../../"

  # Note: Workspace creation is disabled due to cross-account permission limitations in some environments
  # To test workspace functionality, ensure proper DMS account permissions are configured
  create_workspace = false
  workspace_config = {
    workspace_name = "${var.name}-workspace"
    description    = "DMS workspace for ${var.name}"
    vpc_id         = alicloud_vpc.example.id
  }

  # Enterprise instance configuration
  create_enterprise_instance = true
  enterprise_instance_config = {
    tid               = data.alicloud_dms_user_tenants.default.ids[0]
    instance_type     = "mysql"
    instance_source   = "RDS"
    network_type      = "VPC"
    env_type          = "dev"
    host              = alicloud_db_instance.example.connection_string
    port              = 3306
    database_user     = alicloud_db_account.example.account_name
    database_password = alicloud_db_account.example.account_password
    instance_name     = "${var.name}-instance"
    dba_uid           = data.alicloud_account.current.id
    safe_rule         = "904496"
    query_timeout     = 60
    export_timeout    = 600
    ecs_region        = data.alicloud_regions.default.regions[0].id
    use_dsql          = 1
    sell_trust        = true
  }

  # Users configuration (optional)
  create_users = var.create_users
  users_config = var.create_users ? {
    "user1" = {
      uid        = data.alicloud_account.current.id
      user_name  = "dms-user"
      role_names = ["DBA"]
      mobile     = "86-18688888888"
    }
  } : {}

  # Authority templates configuration (optional)
  create_authority_templates = var.create_authority_templates
  authority_templates_config = var.create_authority_templates ? {
    "template1" = {
      tid                     = data.alicloud_dms_user_tenants.default.ids[0]
      authority_template_name = "${var.name}-template"
      description             = "Authority template for ${var.name}"
    }
  } : {}

  # Proxy configuration (optional)
  create_proxy = var.create_proxy
  proxy_config = var.create_proxy ? {
    username = alicloud_db_account.example.account_name
    password = alicloud_db_account.example.account_password
    tid      = data.alicloud_dms_user_tenants.default.ids[0]
    } : {
    username = null
    password = null
  }

  # Proxy accesses configuration (optional)
  # The proxy_id will be automatically populated from the created proxy
  create_proxy_accesses = var.create_proxy_accesses
  proxy_accesses_config = var.create_proxy_accesses ? {
    "access1" = {
      proxy_id       = "" # Auto-populated from created proxy in module
      user_id        = data.alicloud_account.current.id
      indep_account  = alicloud_db_account.example.account_name
      indep_password = alicloud_db_account.example.account_password
    }
  } : {}
}