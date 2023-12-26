variable "name" {
  type = string
}
variable "subnet_ids" {
  type = any
}
variable "name_prefix" {
  type = string
  default = null
}
variable "description" {
  type = string
  default = null
}
variable "tags" {
  type = map(string)
  default = {}
}
