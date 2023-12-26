resource "aws_lb_listener" "this" {
  load_balancer_arn = var.load_balancer_arn
  port              = var.port
  protocol          = var.protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn
  dynamic "default_action" {
    for_each = var.default_action
    content {
      type             = lookup(default_action.value, "type", null)
      target_group_arn = lookup(default_action.value, "target_group_arn", null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

      # dynamic "fixed_response" {
      #   for_each = default_action.value.fixed_response
      #   content {
      #     content_type = fixed_response.value.content_type
      #     message_body = fixed_response.value.message_body
      #     status_code  = fixed_response.value.status_code
      #   }
      # }

      # dynamic "redirect" {
      #   for_each = can(default_action.value.redirect) ? toset(["redirect"]) : toset([])
      #   content {
      #     path        = lookup(redirect.value, "path", null)
      #     host        = lookup(redirect.value, "host", null)
      #     port        = lookup(redirect.value, "port", null)
      #     protocol    = lookup(redirect.value, "protocol", null)
      #     query       = lookup(redirect.value, "query", null)
      #     status_code = lookup(redirect.value, "status_code", null)
      #   }
      # }



      # dynamic "forward" {
      #   for_each = var.forward != null ? toset(["forward"]) : toset([])
      #   content {
      #     dynamic "target_group" {
      #       for_each = can(forward.value.target_group) ? toset(["target_group"]) : toset([])
      #       content {
      #         arn    = lookup(target_group.value, "weight", null)
      #         weight = lookup(target_group.value, "weight", null)
      #       }
      #     }
      #     dynamic "stickiness" {
      #       for_each = can(forward.value.stickiness) ? toset(["stickiness"]) : toset([])

      #       content {
      #         enabled  = lookup(stickiness.value, "enabled", false)
      #         duration = lookup(stickiness.value, "duration", 60)
      #       }
      #     }
      #   }
      # }
