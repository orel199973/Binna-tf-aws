resource "aws_lb" "this" {
  name        = var.name

  load_balancer_type = var.load_balancer_type
  internal           = var.internal
  security_groups    = var.load_balancer_type == "application" ? var.security_groups : null
  subnets            = var.subnets

  idle_timeout                                = var.idle_timeout
  enable_cross_zone_load_balancing            = var.enable_cross_zone_load_balancing
  enable_deletion_protection                  = var.enable_deletion_protection
  enable_http2                                = var.enable_http2
  enable_tls_version_and_cipher_suite_headers = var.enable_tls_version_and_cipher_suite_headers
  enable_xff_client_port                      = var.enable_xff_client_port
  ip_address_type                             = var.ip_address_type
  drop_invalid_header_fields                  = var.drop_invalid_header_fields
  preserve_host_header                        = var.preserve_host_header
  enable_waf_fail_open                        = var.enable_waf_fail_open
  desync_mitigation_mode                      = var.desync_mitigation_mode
  xff_header_processing_mode                  = var.xff_header_processing_mode

  dynamic "access_logs" {
    for_each = var.access_logs  != null ? toset(["access_logs"]) : toset([])

    content {
      enabled = lookup(access_logs.value, "enabled", null)
      bucket  = lookup(access_logs.value, "bucket", null)
      prefix  = lookup(access_logs.value, "prefix", null)
    }
  }

  dynamic "subnet_mapping" {
    for_each = var.subnet_mapping != null ? toset(["subnet_mapping"]) : toset([])

    content {
      subnet_id            = lookup(subnet_mapping.value, "subnet_id", null)
      allocation_id        = lookup(subnet_mapping.value, "allocation_id", null)
      private_ipv4_address = lookup(subnet_mapping.value, "private_ipv4_address", null)
      ipv6_address         = lookup(subnet_mapping.value, "ipv6_address", null)
    }
  }

  tags =merge(
    { "Name" = "${var.name}" },
    var.tags,
  )

  # lifecycle {
  #   create_before_destroy = true
  # }

}
