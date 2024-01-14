resource "aws_acm_certificate" "acm" {
  domain_name       = var.domain_name
  validation_method = var.validation_method

  dynamic "validation_option" {
    for_each = var.validation_option
    content {
      domain_name       = lookup(validation_option.value, "domain_name", null)
      validation_domain = lookup(validation_option.value, "validation_domain", null)
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    var.tags,
    {
      "Environment" = var.environment
    },
  )
}

  terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}