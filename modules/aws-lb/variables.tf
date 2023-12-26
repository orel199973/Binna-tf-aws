variable "name" {
  type        = string
  description = "The name of the Application Load Balancer."
}

variable "load_balancer_type" {
  type        = string
  description = "The type of load balancer (e.g., application,gateway,network)."
}

variable "internal" {
  type        = bool
  description = "Set to true if the ALB should be internal."
  default     = false
}

variable "security_groups" {
  type        = list(string)
  description = "A list of security group IDs for the ALB."
  default     = null
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to attach the ALB to."
  default     = null
}

variable "idle_timeout" {
  type        = number
  description = "The idle timeout value for the ALB."
  default     = 60
}

variable "enable_cross_zone_load_balancing" {
  type        = bool
  description = "Set to true to enable cross-zone load balancing."
}

variable "enable_deletion_protection" {
  type        = bool
  description = "Set to true to enable deletion protection for the ALB."
  default     = false
}

variable "enable_http2" {
  type        = bool
  description = "Set to true to enable HTTP/2 on the ALB."
  default     = true
}

variable "enable_tls_version_and_cipher_suite_headers" {
  type        = bool
  description = "Set to true to enable TLS version and cipher suite headers on the ALB."
  default     = false
}

variable "enable_xff_client_port" {
  type        = bool
  description = "Set to true to enable the X-Forwarded-For (XFF) client port on the ALB."
  default     = false
}

variable "ip_address_type" {
  type        = string
  description = "The type of IP addresses used by the ALB (e.g., 'ipv4,dualstack')."
}

variable "drop_invalid_header_fields" {
  type        = bool
  description = "Set to true to drop requests with invalid header fields."
  default     = false
}

variable "preserve_host_header" {
  type        = bool
  description = "Set to true to preserve the host header on the ALB."
  default     = false
}

variable "enable_waf_fail_open" {
  type        = bool
  description = "Set to true to enable WAF fail-open behavior on the ALB."
  default     = false
}

variable "desync_mitigation_mode" {
  type        = string
  description = "The desync mitigation mode for the ALB."
  default     = "defensive"
}

variable "xff_header_processing_mode" {
  type        = string
  description = "The X-Forwarded-For (XFF) header processing mode for the ALB."
  default     = "append"
}

variable "access_logs" {
  type        = map(string)
  description = "Access logs configuration for the ALB."
  default     = null
}

variable "subnet_mapping" {
  type        = map(string)
  description = "Subnet mapping configuration for the ALB."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "A map of additional tags to assign to the ALB."
  default     = {}
}
