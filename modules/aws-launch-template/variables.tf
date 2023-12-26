variable "name_prefix" {
  type    = any
  default = null
}

variable "description" {
  type    = any
  default = null
}

variable "key_name" {
  type    = any
  default = null
}

variable "user_data" {
  type    = any
  default = null
}

variable "image_id" {
  type = any
}

variable "ram_disk_id" {
  type    = any
  default = null
}

variable "update_default_version" {
  type    = any
  default = null
}

variable "security_group_names" {
  type    = any
  default = null
}

variable "vpc_security_group_ids" {
  type    = any
  default = null
}

variable "instance_type" {
  type = any
}

variable "kernel_id" {
  type    = any
  default = null
}

variable "block_device_mappings" {
  type    = any
  default = {}
}

variable "capacity_reservation_specification" {
  type    = any
  default = {}
}

variable "cpu_options" {
  type    = any
  default = {}
}

variable "credit_specification" {
  type    = any
  default = {}
}

variable "name" {
  type = string
}

variable "elastic_gpu_specifications" {
  type    = any
  default = {}
}

variable "elastic_inference_accelerator" {
  type    = any
  default = {}
}

variable "enclave_options" {
  type    = any
  default = {}
}

variable "hibernation_options" {
  type    = any
  default = {}
}

variable "iam_instance_profile" {
  type    = any
  default = {}
}

variable "spot_options" {
  type    = any
  default = {}
}

variable "instance_market_options" {
  type    = any
  default = {}
}

variable "license_specification" {
  type    = any
  default = {}
}

variable "metadata_options" {
  type    = any
  default = {}
}

variable "monitoring" {
  type    = any
  default = {}
}

variable "network_interfaces" {
  type    = any
  default = {}
}

variable "private_ip_addresses" {
  type    = any
  default = {}
}

variable "placement" {
  type    = any
  default = {}
}

variable "tag_specifications" {
  type    = any
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
