variable "create" {
  description = "Flag to determine whether to create the IPv4 CIDR block association"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the association"
  type        = string
  default = null
}

variable "ipv4_ipam_pool_id" {
  description = "ID of the IPv4 IPAM pool"
  type        = string
  default = null
}

variable "ipv4_netmask_length" {
  description = "Netmask length for the IPv4 CIDR block association"
  type        = number
  default     = null
}