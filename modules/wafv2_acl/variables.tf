variable "name" {
  type    = string
  default = null
}


variable "scope" {
  type    = any
  default = null
}


variable "description" {
  type    = string
  default = null
}


variable "rule" {
  type    = any
  default = {}
}

variable "default_action" {
  type    = any
  default = {}
}

variable "allow" {
  type    = any
  default = {}
}

variable "block" {
  type    = any
  default = {}
}

variable "managed_rule_group_statement" {
  type    = any
  default = {}
}

variable "statement" {
  type    = any
  default = {}
}

variable "geo_match_statement" {
  type    = any
  default = {}
}

variable "country_codes" {
  type    = any
  default = []
}

variable "excluded_rule" {
  type    = any
  default = {}
}

variable "regex_pattern_set_reference_statement" {
  type    = any
  default = {}
}


variable "size_constraint_statement" {
  type    = any
  default = {}
}

variable "scope_down_statement" {
  type    = any
  default = {}
}

variable "rate_based_statement" {
  type    = any
  default = {}
}

variable "visibility_config" {
  type    = any
  default = {}
}

variable "response_header" {
  type    = any
  default = {}
}

variable "action" {
  type    = any
  default = {}
}

variable "custom_response" {
  type    = any
  default = {}
}

variable "custom_request_handling" {
  type    = any
  default = {}
}

variable "insert_header" {
  type    = any
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
