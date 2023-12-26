variable "name" {
  type        = string
}
variable "ami" {
  type        = any
  default     = null
}
variable "instance_type" {
  type        = string
  
}

variable "associate_public_ip_address" {
  type = any
  default = null
}

variable "availability_zone" {
  type = any
  default = null
}

variable "disable_api_stop" {
  type = any
  default = null
}

variable "disable_api_termination" {
  type = any
  default = null
}

variable "ebs_optimized" {
  type = any
  default = null
}

# variable "enclave_options" {
#   type = any
#   default = null
# }

variable "get_password_data" {
  type = any
  default = null
}

variable "hibernation" {
  type = any
  default = null
}

variable "host_id" {
  type = any
  default = null
}

variable "host_resource_group_arn" {
  type = any
  default = null
}

variable "iam_instance_profile" {
  type = any
  default = null
}

variable "instance_initiated_shutdown_behavior" {
  type = any
  default = null
}

variable "ipv6_address_count" {
  type = any
  default = null
}

variable "ipv6_addresses" {
  type = any
  default = null
}

variable "key_name" {
  type = any
  default = null
}

variable "monitoring" {
  type = any
  default = null
}

variable "placement_group" {
  type = any
  default = null
}

variable "placement_partition_number" {
  type = any
  default = null
}

variable "private_dns_name_options" {
  type = any
  default = {}
}

variable "private_ip" {
  type = any
  default = null
}

variable "secondary_private_ips" {
  type = any
  default = null
}

variable "security_groups" {
  type = any
  default = null
}

variable "source_dest_check" {
  type = any
  default = null
}

variable "subnet_id" {
  type = any
  default = null
}

variable "tenancy" {
  type = any
  default = null
}

variable "user_data" {
  type = any
  default = null
}

variable "user_data_base64" {
  type = any
  default = null
}

variable "user_data_replace_on_change" {
  type = any
  default = null
}

variable "volume_tags" {
  type = any
  default = null
}

variable "vpc_security_group_ids" {
  type = any
  default = null
}

variable "network_interface" {
  type = any
  default = {}
}

# variable "instance_market_options" {
#   type        = any
#   default     = {}
# }

variable "capacity_reservation_specification" {
  type        = any
  default     = {}
}

variable "capacity_reservation_target" {
  type        = any
  default     = {}
}

variable "spot_options" {
  type        = any
  default     = {}
}

variable "launch_template" {
  type        = any
  default     = {}
}

variable "cpu_options" {
  type        = any
  default     = {}
}

variable "credit_specification" {
  type        = any
  default     = {}
}

variable "root_block_device" {
  type        = any
  default     = {}
}

variable "ebs_block_device" {
  type        = any
  default     = {}
}

variable "ephemeral_block_device" {
  type        = any
  default     = {}
}

variable "enclave_options" {
  type        = any
  default     = {}
}

variable "maintenance_options" {
  type        = any
  default     = {}
}

variable "instance_market_options" {
  type        = any
  default     = {}
}

variable "metadata_options" {
  type        = any
  default     = {}
}

# variable "network_interface" {
#   type        = any
#   default     = {}
# }

variable "tags" {
  type        = map(string)
  default     = {}
}
