output "id" {
  value = var.create ? aws_transfer_server.this["sftp"].id : data.aws_transfer_server.this.id
}
output "arn" {
  value = var.create ? aws_transfer_server.this["sftp"].arn : data.aws_transfer_server.this.arn
}
output "endpoint" {
  value = var.create ? aws_transfer_server.this["sftp"].endpoint : data.aws_transfer_server.this.endpoint
}

output "security_policy_name" {
  value = var.create ? aws_transfer_server.this["sftp"].security_policy_name : data.aws_transfer_server.this.security_policy_name
}
output "endpoint_type" {
  value = var.create ? aws_transfer_server.this["sftp"].endpoint_type : data.aws_transfer_server.this.endpoint_type
}
output "protocols" {
  value = var.create ? aws_transfer_server.this["sftp"].protocols : data.aws_transfer_server.this.protocols
}
output "identity_provider_type" {
  value = var.create ? aws_transfer_server.this["sftp"].identity_provider_type : data.aws_transfer_server.this.identity_provider_type
}