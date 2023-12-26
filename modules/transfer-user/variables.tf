variable "server_id" {
  description = "The ID of the AWS Transfer server to associate the user with."
  type = any
}


variable "user_name" {
  description = "The desired username for the AWS Transfer user."
  type = string
}
variable "create" {
  type = bool
  default = true
}

variable "role" {
  description = "The ARN of the IAM role that controls the user's access to your Amazon S3 bucket."
  type = any
}

variable "home_directory_type" {
  description = "The type of home directory for the user. Valid values: 'PATH' or 'LOGICAL'"
  default = null
}

variable "policy" {
  description = "The JSON policy document that controls the user's access to the AWS Transfer server."
  default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the AWS Transfer user."
  type        = map(string)
   default = {}
}

variable "posix_profile" {
  description = "A map of POSIX profile settings for the user."
  type        = any
   default = null
}

variable "home_directory_mappings" {
  description = "A map of home directory mappings for the user."
  type        = any
  default = null
}