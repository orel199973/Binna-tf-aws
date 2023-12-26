variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "port" {
  type = number
  default     = null
}

variable "protocol" {
  type = string
  default     = null
}

variable "protocol_version" {
  type = string
  default     = null
}

variable "target_type" {
  type = string
  default     = null
}

variable "connection_termination" {
  type = string
  default     = null
}

variable "deregistration_delay" {
  type = number
  default     = null
}

variable "slow_start" {
  type = number
  default     = null
}

variable "proxy_protocol_v2" {
  type = bool
  default     = null
}

variable "lambda_multi_value_headers_enabled" {
  type = bool
  default     = null
}

variable "load_balancing_algorithm_type" {
  type = string
  default     = null
}

variable "preserve_client_ip" {
  type = bool
  default     = null
}

variable "ip_address_type" {
  type = string
  default     = null
}

variable "load_balancing_cross_zone_enabled" {
  type = bool
  default     = null
}

variable "health_check" {
  type = map(any)
  default = null
}

variable "stickiness" {
  type = map(any)
  default = null
}

variable "tags" {
  type = map(any)
  default = {}
}