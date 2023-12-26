resource "aws_transfer_server" "this" {
  for_each               = var.create ? toset(["sftp"]) : toset([])
  identity_provider_type = var.identity_provider_type
  endpoint_type          = var.endpoint_type
  certificate            = var.certificate
  domain                 = var.domain

  dynamic "endpoint_details" {
    for_each = var.endpoint_details != null ? toset(["endpoint_details"]) : toset([])
    content {
      subnet_ids             = var.endpoint_details.subnet_ids
      address_allocation_ids = var.endpoint_details.address_allocation_ids
      security_group_ids     = var.endpoint_details.security_group_ids
      vpc_endpoint_id        = var.endpoint_details.vpc_endpoint_id
      vpc_id                 = var.endpoint_details.vpc_id
    }
  }
  dynamic "protocol_details" {
    for_each = var.protocol_details != null ? toset(["protocol_details"]) : toset([])
    content {
      as2_transports              = var.protocol_details.as2_transports
      passive_ip                  = var.protocol_details.passive_ip
      set_stat_option             = var.protocol_details.set_stat_option
      tls_session_resumption_mode = var.protocol_details.tls_session_resumption_mode
    }
  }

  protocols                        = var.protocols
  host_key                         = var.host_key
  invocation_role                  = var.invocation_role
  url                              = var.url
  function                         = var.function
  logging_role                     = var.logging_role
  force_destroy                    = var.force_destroy
  directory_id                     = var.directory_id
  post_authentication_login_banner = var.post_authentication_login_banner
  pre_authentication_login_banner  = var.pre_authentication_login_banner

  security_policy_name = var.security_policy_name
  tags                 = var.tags

}
data "aws_transfer_server" "this" {
  server_id = var.create ? aws_transfer_server.this["sftp"].id : var.server_id
}
#   ["FTP", "FTPS"]
#   "${aws_api_gateway_deployment.example.invoke_url}${aws_api_gateway_resource.example.path}"
