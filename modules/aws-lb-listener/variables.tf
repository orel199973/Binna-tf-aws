variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = any
}
variable "name" {
  type = any
}
variable "tags" {
  type = map(string)
  default = {}
}
variable "ssl_policy" {
  type = string
  default = null
}
variable "certificate_arn" {
  type = any
  default = null
}

variable "protocol" {
  type = string
}

variable "default_action" {
  type = any
}

variable "forward" {
  type = map(any)
  default = null
}



