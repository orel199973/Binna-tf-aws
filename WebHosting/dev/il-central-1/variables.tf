variable "environment" {
  type = any
}

variable "company" {
  type = any
}

variable "location" {
  type = any
}

variable "project" {
  type = any
}

variable "vpc" {
  type = any
}

variable "subnet" {
  type = any
}

variable "internet_gateway" {
  type = any
}

variable "elastic_ip" {
  type = any
}

variable "nat_gateway" {
  type = any
}

variable "target_group" {
  type = any
}

variable "acm_domain" {
  type = any
}

variable "alb" {
  type = any
}

variable "security_group_cpanel" {
  type = any
}

variable "security_group_alb" {
  type = any
}


variable "launch_template" {
  type = any
}

variable "autoscaling_group" {
  type = any
}

variable "public_route_table" {
  type = any
}

variable "private_route_table" {
  type = any
}

variable "public_route" {
  type = any
}

variable "private_route" {
  type = any
}

variable "alb_listener_https" {
  type = any
}

variable "alb_listener_http" {
  type = any
}

variable "alb_listener_whm" {
  type = any
}

variable "s3" {
  type = any
}

variable "s3_website" {
  type = any
}

variable "vpc_endpoint" {
  type = any
}

variable "route53_zone" {
  type = any
}

variable "route53_zone_dev" {
  type = any
}

variable "dns_zone_prod_name" {
  type = any
}

variable "dns_zone_dev_name" {
  type = any
}

variable "route53_record_zone_approval" {
  type = any
}

variable "route53_record_cpanel" {
  type = any
}

variable "route53_record_cert_approval" {
  type = any
}

# variable "route53_record_zone_approval_voting" {
#   type = any
# }

# variable "route53_record_cpanel_voting" {
#   type = any
# }

# variable "route53_record_cert_approval_voting" {
#   type = any
# }

# variable "route53_record_cert_approval_us_east_1" {
#   type = any
# }

variable "cloudfront_distribution" {
  type = any
}

variable "wafv2_acl" {
  type = any
}

# variable "wafv2_ip_set" {
#   type = any
# }

variable "target_group_ihorse" {
  type = any
}

variable "alb_ihorse" {
  type = any
}

variable "dns_zone_prod_name_ihorse" {
  type = any
}

variable "dns_zone_dev_ihorse_name" {
  type = any
}

variable "alb_listener_https_ihorse" {
  type = any
}

variable "alb_listener_http_ihorse" {
  type = any
}

variable "alb_listener_whm_ihorse" {
  type = any
}

variable "alb_listener_https_voting" {
  type = any
}

variable "alb_listener_http_voting" {
  type = any
}

variable "alb_listener_whm_voting" {
  type = any
}

# variable "route53_zone_dev_voting" {
#   type = any
# }

variable "route53_record_zone_approval_ihorse" {
  type = any
}

variable "route53_record_cpanel_ihorse" {
  type = any
}


variable "route53_record_cert_approval_ihorse" {
  type = any
}

variable "route53_zone_dev_ihorse" {
  type = any
}

variable "dns_zone_prod_voting_name" {
  type = any
}

variable "cloudfront_distribution_ihorse" {
  type = any
}

variable "cloudfront_distribution_voting" {
  type = any
}

variable "target_group_voting" {
  type = any
}

variable "alb_voting" {
  type = any
}

variable "alb_listener_2083" {
  type = any
}
