variable "vpc_id" {
  type        = any
  default     = null
}
 
variable "availability_zone" {
  type        = any
  default     = null
}

variable "amazon_side_asn" {
  type        = any
  default     = null
}

variable "name" {
  type        = any
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
}
