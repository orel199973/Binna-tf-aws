variable "name" {
  description = "Name of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of storage in GB to allocate to the DB instance"
  type        = number
}

variable "max_allocated_storage" {
  description = "The maximum amount of storage in GB to allocate to the DB instance"
  type        = number
}

variable "availability_zone" {
  description = "The availability zone where the DB instance will be created"
  type        = string
}

variable "engine" {
  description = "The name of the database engine to be used for the DB instance"
  type        = string
}

variable "engine_version" {
  description = "The version number of the database engine to be used for the DB instance"
  type        = string
}

variable "instance_class" {
  description = "The compute and memory capacity of the DB instance"
  type        = string
}

variable "username" {
  description = "The username for the master user"
  type        = string
}

variable "password" {
  description = "The password for the master user"
  type        = string
}

variable "publicly_accessible" {
  description = "Specifies whether the DB instance is publicly accessible"
  type        = bool
}

variable "multi_az" {
  description = "Specifies whether the DB instance is multi-AZ"
  type        = bool
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC security group IDs to associate with the DB instance"
  type        = list(string)
  default     = []
}

variable "port" {
  description = "The port on which the DB accepts connections"
  type        = number
}

variable "backup_retention_period" {
  description = "The number of days to retain automated backups"
  type        = number
  default     = 0
}

variable "backup_window" {
  description = "The daily time range during which automated backups are created"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The weekly time range during which system maintenance can occur"
  type        = string
  default     = null
}

variable "delete_automated_backups" {
  description = "Specifies whether automated backups should be deleted when the DB instance is deleted"
  type        = bool
  default     = true
}

variable "deletion_protection" {
  description = "Specifies whether deletion protection is enabled for the DB instance"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Specifies whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = false
}

variable "final_snapshot_identifier" {
  description = "The name of the final DB snapshot when the DB instance is deleted"
  type        = string
  default     = null
}

variable "storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type        = bool
  default     = false
}
variable "tags" {
  type    = map(string)
  default = {}
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to export to CloudWatch Logs"
  type        = list(string)
  default     = []
}
