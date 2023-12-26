resource "aws_wafv2_web_acl" "wafv2_web_acl" {
  name        = var.name
  scope       = var.scope
  description = var.description

  dynamic "default_action" {
    for_each = var.default_action
    content {
      allow {}
          # dynamic "custom_request_handling" {
          #   for_each = var.custom_request_handling
          #   content {
          #     dynamic "insert_header" {
          #       for_each = var.insert_header
          #       content {
          #         name  = lookup(insert_header.value, "name", null)
          #         value = lookup(insert_header.value, "value", null)
          #       }
          #     }

          #   }

          # }
      dynamic "block" {
        for_each = var.block
        content {
          dynamic "custom_response" {
            for_each = var.custom_response
            content {
              custom_response_body_key = lookup(custom_response.value, "custom_response_body_key", null)
              response_code            = lookup(custom_response.value, "response_code", null)
              dynamic "response_header" {
                for_each = var.response_header
                content {
                  name  = lookup(response_header.value, "name", null)
                  value = lookup(response_header.value, "value", null)
                }
              }
            }

          }

        }
      }

    }
  }

  dynamic "rule" {
    for_each = var.rules
    content {
      name     = lookup(rule.value, "name", null)
      priority = lookup(rule.value, "priority", null)

      dynamic "action" {
        for_each = var.action
        content {
          dynamic "allow" {
            for_each = var.allow
            content {
              dynamic "custom_request_handling" {
                for_each = var.custom_request_handling
                content {
                  dynamic "insert_header" {
                    for_each = var.insert_header
                    content {
                      name  = lookup(custom_request_handling.value, "name", null)
                      value = lookup(custom_request_handling.value, "value", null)
                    }
                  }

                }
              }
            }
          }
          dynamic "block" {
            for_each = var.block
            content {
              dynamic "custom_response" {
                for_each = var.custom_response
                content {
                  custom_response_body_key = lookup(custom_response.value, "custom_response_body_key", null)
                  response_code            = lookup(custom_response.value, "response_code", null)
                  dynamic "response_header" {
                    for_each = var.response_header
                    content {
                      name  = lookup(response_header.value, "name", null)
                      value = lookup(response_header.value, "value", null)
                    }
                  }
                }

              }
            }
          }

          count {}
        }
      }

      dynamic "statement" {
        for_each = var.statement
        content {
          dynamic "managed_rule_group_statement" {
            for_each = var.managed_rule_group_statement
            content {
              name        = lookup(managed_rule_group_statement.value, "name", null)
              vendor_name = lookup(managed_rule_group_statement.value, "vendor_name", null)

              #   dynamic "excluded_rule" {
              #     for_each = var.excluded_rule
              #     content {
              #       name = lookup(excluded_rule.value, "name", null)
              #     }
              #   }

            }
          }

        }
      }


      #   dynamic "rate_based_statement" {
      #     for_each = var.rate_based_statement
      #     content {
      #       limit              = lookup(rate_based_statement.value, "limit", null)
      #       aggregate_key_type = lookup(rate_based_statement.value, "aggregate_key_type", null)

      #       dynamic "scope_down_statement" {
      #         for_each = var.scope_down_statement
      #         content {
      #         }
      #       }
      #     }
      #   }

      dynamic "visibility_config" {
        for_each = lookup(rule.value, "visibility_config", [])
        content {
          cloudwatch_metrics_enabled = lookup(visibility_config.value, "cloudwatch_metrics_enabled", null)
          metric_name                = lookup(visibility_config.value, "metric_name", null)
          sampled_requests_enabled   = lookup(visibility_config.value, "sampled_requests_enabled", null)
        }
      }
    }
  }

  dynamic "visibility_config" {
    for_each = var.visibility_config
    content {
      cloudwatch_metrics_enabled = lookup(visibility_config.value, "cloudwatch_metrics_enabled", null)
      metric_name                = lookup(visibility_config.value, "metric_name", null)
      sampled_requests_enabled   = lookup(visibility_config.value, "sampled_requests_enabled", null)
    }
  }

  #   dynamic "tags" {
  #     for_each = var.tags
  #     content {
  #       key   = tags.key
  #       value = tags.value
  #     }
  #   }
}
