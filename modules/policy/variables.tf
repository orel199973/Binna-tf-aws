variable "name" {
  type = string
}
variable "policy" {
  type = string
}
variable "description" {
  type = string
  default = null
}
variable "path" {
  type = string
}
variable "tags" {
  type = map(string)
  default = {}
}
