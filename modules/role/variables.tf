
variable "name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  type        = any
  default = null
}
variable "assume_role_policy_json" {
  type        = any
  default = null
}

variable "description" {
  description = "The description of the IAM role"
  type        = string
  default = ""
}

variable "managed_policy_arns" {
  description = "A list of ARNs for managed policies to attach to the IAM role"
  type        = list(string)
  default = []
}



variable "inline_policy" {
  description = "Inline policy configuration for the IAM role"
  type        = any
  default     = null
}