resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  enabled             = var.enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = var.comment
  default_root_object = var.default_root_object
  price_class         = var.price_class
  aliases             = var.aliases
  web_acl_id          = var.web_acl_id
  http_version        = var.http_version

  dynamic "origin" {
    for_each = var.origin
    content {
      domain_name              = lookup(origin.value, "domain_name", null)
      origin_id                = lookup(origin.value, "origin_id", null)
      origin_access_control_id = lookup(origin.value, "origin_access_control_id", null)

      dynamic "custom_origin_config" {
        for_each = var.custom_origin_config
        content {
          http_port                = lookup(custom_origin_config.value, "http_port", null)
          https_port               = lookup(custom_origin_config.value, "https_port", null)
          origin_protocol_policy   = lookup(custom_origin_config.value, "origin_protocol_policy", null)
          origin_ssl_protocols     = lookup(custom_origin_config.value, "origin_ssl_protocols", null)
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout", null)
          origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout", null)
        }
      }

      dynamic "s3_origin_config" {
        for_each = var.s3_origin_config
        content {
          origin_access_identity = lookup(s3_origin_config.value, "origin_access_identity", null)
        }
      }
    }
  }

  dynamic "logging_config" {
    for_each = var.logging_configs
    content {
      include_cookies = lookup(logging_configs.value, "include_cookies", null)
      bucket          = lookup(logging_configs.value, "bucket", null)
      prefix          = lookup(logging_configs.value, "prefix", null)
    }
  }

  dynamic "default_cache_behavior" {
    for_each = var.default_cache_behavior
    content {
      allowed_methods          = lookup(default_cache_behavior.value, "allowed_methods",null)
      cached_methods           = lookup(default_cache_behavior.value, "cached_methods", null)
      target_origin_id         = lookup(default_cache_behavior.value, "target_origin_id", var.target_origin_id)
      viewer_protocol_policy   = lookup(default_cache_behavior.value, "viewer_protocol_policy", null)
      min_ttl                  = lookup(default_cache_behavior.value, "min_ttl", null)
      default_ttl              = lookup(default_cache_behavior.value, "default_ttl", null)
      max_ttl                  = lookup(default_cache_behavior.value, "max_ttl", null)
      cache_policy_id          = lookup(default_cache_behavior.value, "cache_policy_id", var.cache_policy_id)
      origin_request_policy_id = lookup(default_cache_behavior.value, "origin_request_policy_id", null)
  #     forwarded_values {
  #       query_string = false
  #       cookies {
  #         forward = "none"
  #       }
  #     }
  #   }
  # }
      dynamic "forwarded_values" {
        for_each = var.forwarded_values
        content {
          query_string = lookup(forwarded_values.value, "query_string", null)
          dynamic "cookies" {
            for_each = var.cookies
            content {
              forward = lookup(cookies.value, "forward", null)
            }

          }
        }
      }
    }
  }
  dynamic "restrictions" {
    for_each = var.restrictions
    content {
      geo_restriction { 
          restriction_type = lookup(restrictions.value, "restriction_type", "whitelist")
          locations        = lookup(restrictions.value, "locations", null)
      }
    }
  }
  # restrictions {
  #     geo_restriction { 
  #         restriction_type = var.restriction_type
  #         locations        = var.locations
  #     }
  # }
  # restrictions {
  #   geo_restriction {
  #     restriction_type = var.restriction_type
  #     locations        = var.locations
  #   }
  # }

  dynamic "viewer_certificate" {
    for_each = var.viewer_certificate
    content {
      cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate", null)
      acm_certificate_arn            = lookup(viewer_certificate.value, "acm_certificate_arn", null)
      ssl_support_method             = lookup(viewer_certificate.value, "ssl_support_method", null)
      minimum_protocol_version       = lookup(viewer_certificate.value, "minimum_protocol_version", null)
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.ordered_cache_behaviors
    content {
      path_pattern           = lookup(ordered_cache_behaviors.value, "path_pattern", null)
      target_origin_id       = lookup(ordered_cache_behaviors.value, "target_origin_id", null)
      viewer_protocol_policy = lookup(default_cache_behavior.value, "viewer_protocol_policy", null)
      allowed_methods        = lookup(default_cache_behavior.value, "allowed_methods", null)
      cached_methods         = lookup(default_cache_behavior.value, "cached_methods", null)
      min_ttl                = lookup(default_cache_behavior.value, "min_ttl", null)
      default_ttl            = lookup(default_cache_behavior.value, "default_ttl", null)
      max_ttl                = lookup(default_cache_behavior.value, "max_ttl", null)

      dynamic "forwarded_values" {
        for_each = var.forwarded_values
        content {
          query_string = lookup(forwarded_values.value, "query_string", null)
          cookies {
            forward = forwarded_values.value["cookies"]["forward"]
          }
        }
      }
    }
  }

  dynamic "custom_error_response" {
    for_each = var.custom_error_response
    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
      error_code            = lookup(custom_error_response.value, "error_code", null)
      response_code         = lookup(custom_error_response.value, "response_code", null)
      response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
    }
  }

  dynamic "origin_group" {
    for_each = var.origin_group
    content {
      origin_id = lookup(origin_group.value, "origin_id", null)

      dynamic "failover_criteria" {
        for_each = var.failover_criteria
        content {
          status_codes = lookup(failover_criteria.value, "status_codes", null)
        }
      }

      dynamic "member" {
        for_each = var.member
        content {
          origin_id = lookup(member.value, "origin_id", null)
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
  )

  lifecycle {
    create_before_destroy = true
  }

}

# resource "aws_cloudfront_distribution" "cloudfront_distribution" {
#   enabled             = var.enabled
#   is_ipv6_enabled     = var.is_ipv6_enabled
#   comment             = var.comment
#   default_root_object = var.default_root_object
#   price_class         = var.price_class
#   aliases             = var.aliases
#   web_acl_id          = var.web_acl_id
#   http_version        = var.http_version

#   dynamic "origin" {
#     for_each = var.origin
#     content {
#       domain_name              = lookup(origin.value, "domain_name", null)
#       origin_id                = lookup(origin.value, "origin_id", null)
#       origin_access_control_id = lookup(origin.value, "origin_access_control_id", null)

#       dynamic "custom_origin_config" {
#         for_each = var.custom_origin_config
#         content {
#           http_port                = lookup(custom_origin_config.value, "http_port", null)
#           https_port               = lookup(custom_origin_config.value, "https_port", null)
#           origin_protocol_policy   = lookup(custom_origin_config.value, "origin_protocol_policy", null)
#           origin_ssl_protocols     = lookup(custom_origin_config.value, "origin_ssl_protocols", null)
#           origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout", null)
#           origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout", null)
#         }
#       }

#       dynamic "s3_origin_config" {
#         for_each = var.s3_origin_config
#         content {
#           origin_access_identity = lookup(s3_origin_config.value, "origin_access_identity", null)
#         }
#       }
#     }
#   }

#   dynamic "logging_config" {
#     for_each = var.logging_configs
#     content {
#       include_cookies = lookup(logging_configs.value, "include_cookies", null)
#       bucket          = lookup(logging_configs.value, "bucket", null)
#       prefix          = lookup(logging_configs.value, "prefix", null)
#     }
#   }

#   dynamic "default_cache_behavior" {
#     for_each = var.default_cache_behavior
#     content {
#       allowed_methods          = lookup(default_cache_behavior.value, "allowed_methods", null)
#       cached_methods           = lookup(default_cache_behavior.value, "cached_methods", null)
#       target_origin_id         = lookup(default_cache_behavior.value, "target_origin_id", var.target_origin_id)
#       viewer_protocol_policy   = lookup(default_cache_behavior.value, "viewer_protocol_policy", null)
#       min_ttl                  = lookup(default_cache_behavior.value, "min_ttl", null)
#       default_ttl              = lookup(default_cache_behavior.value, "default_ttl", null)
#       max_ttl                  = lookup(default_cache_behavior.value, "max_ttl", null)
#       cache_policy_id          = lookup(default_cache_behavior.value, "cache_policy_id", var.cache_policy_id)
#       origin_request_policy_id = lookup(default_cache_behavior.value, "origin_request_policy_id", null)

#       forwarded_values {
#         query_string = false
#         cookies {
#           forward = "none"
#         }
#       }
#     }
#   }

#   dynamic "restrictions" {
#     for_each = var.restrictions
#     content {
#       geo_restriction {
#         restriction_type = lookup(restrictions.value, "restriction_type", null)
#         locations        = lookup(restrictions.value, "locations", null)
#       }
#     }
#   }

#   dynamic "viewer_certificate" {
#     for_each = var.viewer_certificate
#     content {
#       cloudfront_default_certificate = lookup(viewer_certificate.value, "cloudfront_default_certificate", null)
#       acm_certificate_arn            = lookup(viewer_certificate.value, "acm_certificate_arn", null)
#       ssl_support_method             = lookup(viewer_certificate.value, "ssl_support_method", null)
#       minimum_protocol_version       = lookup(viewer_certificate.value, "minimum_protocol_version", null)
#     }
#   }

#   dynamic "ordered_cache_behavior" {
#     for_each = var.ordered_cache_behaviors
#     content {
#       path_pattern           = lookup(ordered_cache_behaviors.value, "path_pattern", null)
#       target_origin_id       = lookup(ordered_cache_behaviors.value, "target_origin_id", null)
#       viewer_protocol_policy = lookup(default_cache_behavior.value, "viewer_protocol_policy", null)
#       allowed_methods        = lookup(default_cache_behavior.value, "allowed_methods", null)
#       cached_methods         = lookup(default_cache_behavior.value, "cached_methods", null)
#       min_ttl                = lookup(default_cache_behavior.value, "min_ttl", null)
#       default_ttl            = lookup(default_cache_behavior.value, "default_ttl", null)
#       max_ttl                = lookup(default_cache_behavior.value, "max_ttl", null)

#       forwarded_values {
#         query_string = false
#         cookies {
#           forward = "none"
#         }
#       }
#     }
#   }

#   dynamic "custom_error_response" {
#     for_each = var.custom_error_response
#     content {
#       error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl", null)
#       error_code            = lookup(custom_error_response.value, "error_code", null)
#       response_code         = lookup(custom_error_response.value, "response_code", null)
#       response_page_path    = lookup(custom_error_response.value, "response_page_path", null)
#     }
#   }

#   dynamic "origin_group" {
#     for_each = var.origin_group
#     content {
#       origin_id = lookup(origin_group.value, "origin_id", null)

#       dynamic "failover_criteria" {
#         for_each = var.failover_criteria
#         content {
#           status_codes = lookup(failover_criteria.value, "status_codes", null)
#         }
#       }

#       dynamic "member" {
#         for_each = var.member
#         content {
#           origin_id = lookup(member.value, "origin_id", null)
#         }
#       }
#     }
#   }

#   tags = merge(
#     var.tags,
#     {
#       "Name" = var.name
#     },
#   )

#   lifecycle {
#     create_before_destroy = true
#   }

# }
