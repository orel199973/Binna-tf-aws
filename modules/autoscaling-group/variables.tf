variable "desired_capacity" {
  type    = any
  default = null
}

variable "max_size" {
  type    = any
  default = null
}

variable "min_size" {
  type    = any
  default = null
}

variable "vpc_zone_identifier" {
  type    = any
  default = null
}

variable "force_delete" {
  type    = any
  default = null
}

variable "health_check_type" {
  type    = any
  default = null
}

variable "health_check_grace_period" {
  type    = any
  default = null
}

variable "launch_configuration" {
  type    = any
  default = null
}

variable "target_group_arns" {
  type    = any
  default = null
}


variable "service_linked_role_arn" {
  type    = any
  default = null
}

variable "termination_policies" {
  type    = any
  default = null
}

variable "enabled_metrics" {
  type    = any
  default = null
}

variable "suspended_processes" {
  type    = any
  default = null
}

variable "placement_group" {
  type    = any
  default = null
}

variable "min_elb_capacity" {
  type    = any
  default = null
}

variable "max_instance_lifetime" {
  type    = any
  default = null
}

variable "load_balancers" {
  type    = any
  default = null
}


variable "availability_zones" {
  type    = any
  default = null
}

variable "tag" {
  type    = any
  default = {}
}

variable "mixed_instances_policy" {
  type    = any
  default = {}
}

variable "launch_template" {
  type    = any
  default = {}
}

variable "launch_template_specification" {
  type    = any
  default = {}
}

variable "instances_distribution" {
  type    = any
  default = {}
}

variable "override" {
  type    = any
  default = {}
}

variable "lifecycle_hook" {
  type    = any
  default = {}
}

variable "instance_refresh" {
  type    = any
  default = {}
}

variable "preferences" {
  type    = any
  default = {}
}