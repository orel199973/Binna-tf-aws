variable "name" {
  type        = string
  description = "The name of the S3 Bucket."
}
variable "bucket" {
  type = any
}
variable "index_document" {
  type = any
}
variable "error_document" {
  type = any
}
variable "routing_rule" {
  type = string
}
variable "expected_bucket_owner" {
  type = string
}
# variable "redirect_all_requests_to" {
#   type = any
# } 
variable "tags" {
  type        = map(string)
  description = "A map of additional tags to assign to the S3 Bucket."
  default     = {}
}

