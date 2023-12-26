resource "aws_db_instance" "this" {
  identifier = var.name
  # Storage
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  availability_zone     = var.availability_zone
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  # Database Access
  db_name             = var.name
  username            = var.username
  password            = var.password
  publicly_accessible = var.publicly_accessible
  # Networking
  multi_az               = var.multi_az
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.vpc_security_group_ids
  port                   = var.port
  # Backups and Maintenance
  backup_retention_period  = var.backup_retention_period
  backup_window            = var.backup_window
  maintenance_window       = var.maintenance_window
  delete_automated_backups = var.delete_automated_backups
  # General Options
  deletion_protection       = var.deletion_protection
  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot == true ? "${var.name}-snapshot" : null
  storage_encrypted         = var.storage_encrypted
  # logs
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  tags                            = var.tags
}
