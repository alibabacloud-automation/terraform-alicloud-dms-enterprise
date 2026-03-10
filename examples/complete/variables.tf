variable "region" {
  description = "The region where to deploy the resources"
  type        = string
  default     = "cn-hangzhou"
}

variable "zone_id" {
  description = "The zone ID where to deploy the resources (auto-detected from available zones if not specified)"
  type        = string
  default     = null
}

variable "name" {
  description = "The name prefix for all resources"
  type        = string
  default     = "terraform-dms-example"
}

variable "create_users" {
  description = "Whether to create DMS Enterprise users in the example"
  type        = bool
  default     = false
}

variable "create_authority_templates" {
  description = "Whether to create DMS Enterprise authority templates in the example"
  type        = bool
  default     = true
}

variable "create_proxy" {
  description = "Whether to create DMS Enterprise proxy in the example"
  type        = bool
  default     = false
}

variable "create_proxy_accesses" {
  description = "Whether to create DMS Enterprise proxy accesses in the example"
  type        = bool
  default     = false
}