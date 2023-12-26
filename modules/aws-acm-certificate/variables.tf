
variable "domain_name" {
  type    = string
  default = null
}

variable "validation_method" {
  type    = string
  default = null
}


variable "validation_option" {
  type    = any
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "environment" {
  type    = string
  default = null
}