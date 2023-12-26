variable "create" {
  description = "Flag to determine whether to create the AWS Transfer Server resource"
  type        = bool
  default     = true
}

variable "endpoint_type" {
  description = "The type of endpoint for the AWS Transfer Server"
  type        = string
  default     = null
}

variable "certificate" {
  description = "The Amazon Resource Name (ARN) of the certificate to be used by the AWS Transfer Server"
  type        = string
  default     = null
}
variable "server_id" {
  type        = string
  default     = null
}
variable "domain" {
  description = "The domain of the AWS Transfer Server"
  type        = string
  default     = null
}

variable "endpoint_details" {
  description = "Details for the AWS Transfer Server endpoint"
  type = object({
    subnet_ids             = optional(list(string))
    address_allocation_ids = optional(list(string))
    security_group_ids     = optional(list(string))
    vpc_endpoint_id        = optional(string)
    vpc_id                 = optional(string)
  })
  default = {}
}
variable "protocol_details" {
  description = "Additional details for the AWS Transfer Server protocols"
  type = object({
    as2_transports              = optional(list(string))
    passive_ip                  = optional(string)
    set_stat_option             = optional(string)
    tls_session_resumption_mode = optional(string)
  })
  default = {}
}
variable "protocols" {
  description = "The protocols to be used by the AWS Transfer Server"
  type        = list(string)
  default     = null
}

variable "host_key" {
  description = "The public key portion of the host key used by the AWS Transfer Server"
  type        = string
  default     = null
}

variable "invocation_role" {
  description = "The Amazon Resource Name (ARN) of the IAM role used to authenticate the AWS Transfer Server"
  type        = string
  default     = null
}

variable "identity_provider_type" {
  description = "The type of identity provider used for user authentication"
  type        = string
}
variable "url" {
  description = "The URL of the AWS Transfer Server"
  type        = string
  default     = null
}
variable "function" {
  description = "The AWS Lambda function to be used by the AWS Transfer Server"
  type        = string
  default     = null
}
variable "logging_role" {
  description = "The Amazon Resource Name (ARN) of the IAM role used for logging"
  type        = string
  default     = null
}
variable "force_destroy" {
  description = "Flag to determine whether to destroy the AWS Transfer Server even if it has resources attached"
  type        = bool
  default     = false
}
variable "directory_id" {
  description = "The ID of the AWS Directory Service directory associated with the AWS Transfer Server"
  type        = string
  default     = null
}
variable "post_authentication_login_banner" {
  description = "The message displayed to users after they authenticate"
  type        = string
  default     = null
}
variable "pre_authentication_login_banner" {
  description = "The message displayed to users before they authenticate"
  type        = string
  default     = null
}
variable "security_policy_name" {
  description = "The name of the security policy to be associated with the AWS Transfer Server"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be assigned to the AWS Transfer Server"
  type        = map(string)
  default     = {}
}
