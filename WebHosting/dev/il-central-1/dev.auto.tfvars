# Global Vars
# ----------------
environment = "dev"
company     = "binna"
project     = "web"
location    = "il-central-1"


# VPCs
# -----------------
vpc = {
  vpc = {
    cidr_block = "172.30.0.0/16"
    # enable_dns_support = true
    # enable_dns_hostnames = true

  }
}


# Subnets
# -----------------
subnet = {
  public-subnet-1a = {
    cidr_block              = "172.30.1.0/24"
    availability_zone       = "il-central-1a"
    map_public_ip_on_launch = true
  }
  public-subnet-1b = {
    cidr_block              = "172.30.2.0/24"
    availability_zone       = "il-central-1b"
    map_public_ip_on_launch = true
  }
  private-subnet-1a = {
    cidr_block              = "172.30.3.0/24"
    availability_zone       = "il-central-1a"
    map_public_ip_on_launch = false
  }
}


# Internet Gateway
# -----------------
internet_gateway = {
  ig = {

  }
}


# Elastic IP
# -----------------
elastic_ip = {
  eip-natgw = {
    vpc = true

  }
}


# nat_gateway
# -----------------
nat_gateway = {
  natgw = {

  }
}

# #  Route Table
# # ---------------
public_route_table = {
  public-route-table = {

  }
}

private_route_table = {
  private-route-table = {

  }
}


# #  Route
# # -------
public_route = {
  public-route = {
    destination_cidr_block = "0.0.0.0/0"
  }
}
private_route = {
  private-route = {
    destination_cidr_block = "0.0.0.0/0"
  }
}


# Security Groups
# -----------------
security_group_cpanel = {
  security-group-cpanel = {
    ingress = [{
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      },
      {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
      },
      {
        from_port = 443
        to_port   = 443
        protocol  = "tcp"
      },
      {
        from_port = 2082
        to_port   = 2082
        protocol  = "tcp"
      }
      ,
      {
        from_port = 2083
        to_port   = 2083
        protocol  = "tcp"
      },
      {
        from_port = 2086
        to_port   = 2086
        protocol  = "tcp"
      },
      {
        from_port = 2087
        to_port   = 2087
        protocol  = "tcp"
    }]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}


security_group_alb = {
  security-group-alb = {
    ingress = [{
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 2082
        to_port     = 2082
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
      ,
      {
        from_port   = 2083
        to_port     = 2083
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 2086
        to_port     = 2086
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        from_port   = 2087
        to_port     = 2087
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}




# # Launch Template
# # -----------------
launch_template = {
  cPanel = {
    name_prefix            = "cPanel"
    image_id               = "ami-0dfc5826ab822f025"
    instance_type          = "t3.small"
    update_default_version = true
    block_device_mappings = [{
      device_name = "/dev/sda1"
      ebs = [{
        volume_size           = 40
        volume_type           = "gp2"
        delete_on_termination = true
      }]
      network_interfaces = [{
        associate_public_ip_address = false
        delete_on_termination       = true
        description                 = "cPanel network interface"
        device_index                = 0
      }]

    }]
  }
}


# # Autoscaling Group
# # ------------------
autoscaling_group = {
  autoscaling-group = {
    max_size         = 1
    min_size         = 1
    desired_capacity = 1
    # availability_zones = ["il-central-1a"]
    launch_template = [{
      version = "$Default"
    }]
  }
}


# # Target Group
# # -----------------
target_group = {
  tg-http = {
    target_type = "instance"
    port        = 80
    protocol    = "HTTP"
  }
  tg-whm = {
    target_type = "instance"
    port        = 2087
    protocol    = "HTTPS"
  }
}


# # Certificate Manager
# # --------------------
acm_domain = "*.dev.vitiligo-stop.com"


# ALB
# -----------------
alb = {
  alb = {
    internal                   = false
    load_balancer_type         = "application"
    enable_deletion_protection = false

  }
}


# ALB Listener
# -----------------
alb_listener_http = {
  listener-http = {
    protocol = "HTTP"
    port     = "80"
    type     = "forward"
  }
}

alb_listener_https = {
  listener-https = {
    protocol   = "HTTPS"
    port       = "443"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    type       = "forward"
  }
}

alb_listener_whm = {
  listener-whm = {
    protocol   = "HTTPS"
    port       = "2087"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    type       = "forward"
  }
}


# S3 Bucket
# -----------------
s3 = {
  s3 = {

  }
}


# S3 WebSite
# -----------------
s3_website = {
  s3-website = {
    index_document = [{
      suffix = "index.html"
    }]

    error_document = [{
      key = "error.html"
    }]

    routing_rule = <<EOF
    [{
        "Condition": {
            "KeyPrefixEquals": "docs/"
        },
        "Redirect": {
            "ReplaceKeyPrefixWith": ""
        }
    }]
    EOF

  }
}

# VPC Endpoint
# -----------------
vpc_endpoint = {
  vpc-endpoint = {
    service_name      = "com.amazonaws.il-central-1.s3"
    vpc_endpoint_type = "Interface"
    # private_dns_enabled = true
  }
}



# # Route53 Zone
# # -----------------
dns_zone_prod_name = "vitiligo-stop.com"
dns_zone_dev_name  = "*.dev.vitiligo-stop.com"
route53_zone = {
  vitiligo-stop = {
  }
}
route53_zone_dev = {
  vitiligo-stop = {
  }
}


# # Route53 Record
# # -----------------
route53_record_zone_approval = {
  cert-approval = {
    allow_overwrite = true
    name            = "dev.vitiligo-stop.com"
    type            = "NS"
    ttl             = 172800
  }
}
route53_record_cpanel = {
  cpanel-a = {
    name = "cpanel.dev.vitiligo-stop.com"
    type = "A"
    alias = [{
      evaluate_target_health = true
    }]
  }
}
route53_record_cert_approval = {
  cert-vitiligo-stop = {
    type = "CNAME"
    ttl  = 60
  }
}


# # Cloudfront Distribution
# # # ------------------------
cloudfront_distribution = {
  cloudfront = {
    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    origin_id           = "ALB"
    origin = [{
    }]
    custom_origin_config = [{
      http_port  = 80
      https_port = 443
      # origin_keepalive_timeout = 5
      # origin_read_timeout      = 30
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols   = ["TLSv1.2"]
    }]
    default_cache_behavior = [{
      target_origin_id       = "ALB"
      viewer_protocol_policy = "redirect-to-https"
      min_ttl                = 0
      default_ttl            = 3600
      max_ttl                = 86400
      allowed_methods        = ["GET", "HEAD"]
      cached_methods         = ["GET", "HEAD"]
      forwarded_values = [{
        query_string = false
        forward      = "none"
        cookies = [{
        }]
      }]
    }]
    viewer_certificate = [{
      ssl_support_method       = "sni-only"
      minimum_protocol_version = "TLSv1.2_2019"
    }]
    restrictions = [{
      geo_restriction = [{
        restriction_type = "whitelist"
        locations        = ["IL"]
      }]
    }]

  }
}


# # WAF ACL
# # ------------------------
wafv2_acl = {
  waf = {
    scope         = "CLOUDFRONT"
    country_codes = ["IL"]
    default_action = [{
    }]
    rule = [{
      name     = "AllowOnlyIsrael"
      priority = 1
      action = [{
      }]
      visibility_config = [{
        cloudwatch_metrics_enabled = false
        metric_name                = "web-acl"
        sampled_requests_enabled   = false
      }]
    }]
    visibility_config = [{
      cloudwatch_metrics_enabled = false
      metric_name                = "web-acl"
      sampled_requests_enabled   = false
    }]
  }
}


# #  WAF IP Set
# # ------------------------
# wafv2_ip_set = {
#   ip-set = {
#     description        = "Example IP set"
#     scope              = "REGIONAL"
#     ip_address_version = "IPV4"
#     addresses          = ["1.2.3.4/32", "5.6.7.8/32"]
#   }
# }
