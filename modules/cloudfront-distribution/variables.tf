variable "name" {
  type = string
}

variable "s3_origin_id" {
  type    = any
  default = null
}

variable "enabled" {
  type    = any
  default = null
}


variable "is_ipv6_enabled" {
  type    = any
  default = null
}

variable "target_origin_id" {
  type    = any
  default = null
}

variable "cache_policy_id" {
  type    = any
  default = null
}

variable "web_acl_id" {
  type    = any
  default = null
}

variable "http_version" {
  type    = any
  default = null
}

variable "default_root_object" {
  type    = any
  default = null
}


variable "aliases" {
  type    = any
  default = null
}


variable "price_class" {
  type    = any
  default = null
}

variable "comment" {
  type    = any
  default = null
}

variable "origin" {
  type    = any
  default = {}
}

variable "s3_origin_config" {
  type    = any
  default = {}
}

variable "custom_origin_config" {
  type    = any
  default = {}
}

variable "restrictions" {
  type    = any
  default = {}
}

variable "geo_restriction" {
  type = any
}

# variable "locations" {
#   type    = any
#   default = null
# }

# variable "restriction_type" {
#   type    = any
#   default = null
# }

variable "default_cache_behavior" {
  type    = any
  default = {}
}

variable "viewer_certificate" {
  type    = any
  default = {}
}

variable "forwarded_values" {
  type = any
}

variable "cookies" {
  type    = any
  default = {}
}

variable "logging_configs" {
  type    = any
  default = {}
}

variable "ordered_cache_behaviors" {
  type    = any
  default = {}
}

variable "custom_error_response" {
  type    = any
  default = {}
}

variable "origin_group" {
  type    = any
  default = {}
}

variable "failover_criteria" {
  type    = any
  default = {}
}

variable "member" {
  type    = any
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
