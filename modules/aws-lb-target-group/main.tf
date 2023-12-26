resource "aws_lb_target_group" "this" {

  name             = var.name
  vpc_id           = var.vpc_id
  port             = var.port
  protocol         = var.protocol
  protocol_version = var.protocol_version
  target_type      = var.target_type

  connection_termination             = var.connection_termination
  deregistration_delay               = var.deregistration_delay
  slow_start                         = var.slow_start
  proxy_protocol_v2                  = var.proxy_protocol_v2
  lambda_multi_value_headers_enabled = var.lambda_multi_value_headers_enabled
  load_balancing_algorithm_type      = var.load_balancing_algorithm_type
  preserve_client_ip                 = var.preserve_client_ip
  ip_address_type                    = var.ip_address_type
  load_balancing_cross_zone_enabled  = var.load_balancing_cross_zone_enabled

  dynamic "health_check" {
    for_each = var.health_check != null ? toset(["health_check"]) : toset([])

    content {
      enabled             = lookup(health_check.value, "enabled", null)
      interval            = lookup(health_check.value, "interval", null)
      path                = lookup(health_check.value, "path", null)
      port                = lookup(health_check.value, "port", null)
      healthy_threshold   = lookup(health_check.value, "healthy_threshold", null)
      unhealthy_threshold = lookup(health_check.value, "unhealthy_threshold", null)
      timeout             = lookup(health_check.value, "timeout", null)
      protocol            = lookup(health_check.value, "protocol", null)
      matcher             = lookup(health_check.value, "matcher", null)
    }
  }

  dynamic "stickiness" {
    for_each = var.health_check != null ? toset(["stickiness"]) : toset([])

    content {
      enabled         = lookup(stickiness.value, "enabled", null)
      cookie_duration = lookup(stickiness.value, "cookie_duration", null)
      type            = lookup(stickiness.value, "type", null)
      cookie_name     = lookup(stickiness.value, "cookie_name", null)
    }
  }

  tags = merge(
    { "Name" = "${var.name}" },
    var.tags,
  )

  lifecycle {
    create_before_destroy = true
  }
}
