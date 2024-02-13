locals {
  name-prefix = {
    environment = var.environment
    company     = var.company
    project     = var.project
  }
  prefix = "${var.company}-${var.project}-${var.environment}"
}


# VPC
# -----------------
module "vpc" {
  source     = "../../../modules/vpc"
  for_each   = var.vpc
  name       = "${each.key}-${local.prefix}"
  cidr_block = each.value.cidr_block
  # enable_dns_support = lookup(each.value, "enable_dns_support", null)
  # enable_dns_hostnames = lookup(each.value, "enable_dns_hostnames", null)
}


# Subnet
# -----------------
module "subnet" {
  source                  = "../../../modules/subnet"
  for_each                = var.subnet
  name                    = "${each.key}-${local.prefix}"
  vpc_id                  = module.vpc["vpc"].id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = lookup(each.value, "map_public_ip_on_launch", null)
}


# Internet Gateway
# -----------------
module "internet_gateway" {
  source   = "../../../modules/aws-internet-gateway"
  for_each = var.internet_gateway
  name     = "${each.key}-${local.prefix}"
  vpc_id   = module.vpc["vpc"].id
}


# # Elastic IP
# # -----------------
module "elastic_ip" {
  source   = "../../../modules/aws-eip"
  for_each = var.elastic_ip
  name     = "${each.key}-${local.prefix}"
}


# NAT Gateway
# -----------------
module "nat_gateway" {
  source        = "../../../modules/aws-nat-gateway"
  for_each      = var.nat_gateway
  name          = "${each.key}-${local.prefix}"
  subnet_id     = module.subnet["public-subnet-1a"].id
  allocation_id = module.elastic_ip["eip-natgw"].id
  depends_on    = [module.internet_gateway]
}


# Security Group
# -----------------
module "security_group_cpanel" {
  source          = "../../../modules/security-group"
  for_each        = var.security_group_cpanel
  name            = "${each.key}-${local.prefix}"
  vpc_id          = module.vpc["vpc"].id
  egress          = lookup(each.value, "egress", null)
  ingress         = lookup(each.value, "ingress", null)
  security_groups = [module.security_group_alb["security-group-alb"].id, module.security_group_alb["security-group-alb-ihorse"].id, module.security_group_alb["security-group-alb-voting"].id]
}

module "security_group_alb" {
  source   = "../../../modules/security-group"
  for_each = var.security_group_alb
  name     = "${each.key}-${local.prefix}"
  vpc_id   = module.vpc["vpc"].id
  ingress  = lookup(each.value, "ingress", null)
  egress   = lookup(each.value, "egress", null)
}


resource "aws_key_pair" "cPanel-key" {
  key_name   = "cPanel-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO31kDZ00k9zMyeBrBMYEIsNl7qOZVXXnIePAfHYEkT3L7vozBW05ATYNxZ84SgKAPc80aoEiBqP3FNXJlGUBNr05kds2GRgH5f4bdM/UVjQwfM4TK7dh84PoIosTzexRoLGQdovOz2a3D4tquDUajBpfj2G4TD1IS8ETDTFAwNHTDKRQSQxpKPnYEexpxA4JzOQ5HRmSO1o79UI7G0OhcZfSaHuMSZ8wNjuyXe+ycbOFrfc37NKrK8i5m8kZxd0mdYs6ZrO3LvuIabaw/cjaougvZoGfX8hkurkmBcp45wQIZ8vDDBL+CRLv7ynYsvns974UHzJrAWnmmKy1jeMxN rsa-key-20231224"
}


# cPanel Launch Template
# -----------------------
module "launch_template" {
  source                 = "../../../modules/aws-launch-template"
  for_each               = var.launch_template
  name                   = "${each.key}-${local.prefix}"
  block_device_mappings  = lookup(each.value, "block_device_mappings", {})
  update_default_version = lookup(each.value, "update_default_version", null)
  image_id               = lookup(each.value, "image_id", null)
  user_data              = lookup(each.value, "user_data", null)
  instance_type          = lookup(each.value, "instance_type", null)
  # vpc_security_group_ids = [module.security_group_cpanel["security-group-cpanel"].id]
  key_name = aws_key_pair.cPanel-key.key_name
  network_interfaces = [{
    subnet_id                   = module.subnet["private-subnet-1a"].id
    security_groups             = [module.security_group_cpanel["security-group-cpanel"].id, module.security_group_alb["security-group-alb-ihorse"].id, module.security_group_alb["security-group-alb-voting"].id]
    associate_public_ip_address = lookup(each.value, "associate_public_ip_address", null)
  }]
}


# # Target Group
# # -----------------
module "target_group" {
  source      = "../../../modules/aws-lb-target-group"
  for_each    = var.target_group
  name        = "${each.key}-${local.prefix}"
  vpc_id      = module.vpc["vpc"].id
  port        = lookup(each.value, "port", null)
  protocol    = lookup(each.value, "protocol", null)
  target_type = lookup(each.value, "target_type", null)
}

module "target_group_ihorse" {
  source      = "../../../modules/aws-lb-target-group"
  for_each    = var.target_group_ihorse
  name        = "${each.key}-${local.prefix}"
  vpc_id      = module.vpc["vpc"].id
  port        = lookup(each.value, "port", null)
  protocol    = lookup(each.value, "protocol", null)
  target_type = lookup(each.value, "target_type", null)
}

module "target_group_voting" {
  source      = "../../../modules/aws-lb-target-group"
  for_each    = var.target_group_voting
  name        = "${each.key}-${local.prefix}"
  vpc_id      = module.vpc["vpc"].id
  port        = lookup(each.value, "port", null)
  protocol    = lookup(each.value, "protocol", null)
  target_type = lookup(each.value, "target_type", null)
}

# Autoscaling Group
# ------------------
module "autoscaling_group" {
  source              = "../../../modules/autoscaling-group"
  for_each            = var.autoscaling_group
  max_size            = lookup(each.value, "max_size", null)
  min_size            = lookup(each.value, "min_size", null)
  vpc_zone_identifier = [module.subnet["private-subnet-1a"].id]
  target_group_arns   = [module.target_group["tg-http"].arn, module.target_group["tg-whm"].arn, module.target_group["tg-2083"].arn, module.target_group_ihorse["ihorse-tg-http"].arn, module.target_group_ihorse["ihorse-tg-whm"].arn, module.target_group_voting["voting-tg-http"].arn, module.target_group_voting["voting-tg-whm"].arn]
  launch_template = [{
    id      = module.launch_template["cPanel"].id
    version = lookup(each.value, "version", null)
  }]
  depends_on = [module.launch_template, module.target_group]
}

# #  Route Table
# # ----------------
## Public:
module "public_route_table" {
  source   = "../../../modules/route-table"
  for_each = var.public_route_table
  name     = each.key
  vpc_id   = module.vpc["vpc"].id
}

## Private:
module "private_route_table" {
  source   = "../../../modules/route-table"
  for_each = var.private_route_table
  name     = each.key
  vpc_id   = module.vpc["vpc"].id
}

# #  Route
# # -------
## Public:
module "public_route" {
  source                 = "../../../modules/route"
  for_each               = var.public_route
  route_table_id         = module.public_route_table["public-route-table"].id
  destination_cidr_block = lookup(each.value, "destination_cidr_block", null)
  gateway_id             = module.internet_gateway["ig"].id
}
## Private:
module "private_route" {
  source                 = "../../../modules/route"
  for_each               = var.private_route
  route_table_id         = module.private_route_table["private-route-table"].id
  destination_cidr_block = lookup(each.value, "destination_cidr_block", null)
  nat_gateway_id         = module.nat_gateway["natgw"].id
}


# #  Association Route Table
# # -------------------------
## Public1:
module "public1_association_route_table" {
  source         = "../../../modules/route-table-association"
  subnet_id      = module.subnet["public-subnet-1a"].id
  route_table_id = module.public_route_table["public-route-table"].id
}
# Public2:
module "public2_association_route_table" {
  source         = "../../../modules/route-table-association"
  subnet_id      = module.subnet["public-subnet-1b"].id
  route_table_id = module.public_route_table["public-route-table"].id
}
## Private:
module "private_association_route_table" {
  source         = "../../../modules/route-table-association"
  subnet_id      = module.subnet["private-subnet-1a"].id
  route_table_id = module.private_route_table["private-route-table"].id
}


# # Certificate Manager
# # --------------------
module "acm_certificate_dev_israel" {
  source            = "../../../modules/aws-acm-certificate"
  domain_name       = var.dns_zone_dev_name
  validation_method = "DNS"
  providers = {
    aws = aws.default
  }
}

module "acm_certificate_dev_us_east1" {
  source            = "../../../modules/aws-acm-certificate"
  domain_name       = var.dns_zone_dev_name
  validation_method = "DNS"
  providers = {
    aws = aws.us_east_1
  }
}

module "acm_certificate_dev_ihorse_israel" {
  source            = "../../../modules/aws-acm-certificate"
  domain_name       = var.dns_zone_dev_ihorse_name
  validation_method = "DNS"
  providers = {
    aws = aws.default
  }
}

module "acm_certificate_dev_ihorse_us_east1" {
  source            = "../../../modules/aws-acm-certificate"
  domain_name       = var.dns_zone_dev_ihorse_name
  validation_method = "DNS"
  providers = {
    aws = aws.us_east_1
  }
}

module "acm_certificate_voting_israel" {
  source            = "../../../modules/aws-acm-certificate"
  domain_name       = var.dns_zone_prod_voting_name
  validation_method = "DNS"
  providers = {
    aws = aws.default
  }
}

module "acm_certificate_voting_us_east1" {
  source            = "../../../modules/aws-acm-certificate"
  domain_name       = var.dns_zone_prod_voting_name
  validation_method = "DNS"
  providers = {
    aws = aws.us_east_1
  }
}

# data "aws_acm_certificate" "vitiligo_stop_dev_israel" {
#   domain   = var.acm_domain
#   provider = aws.default
# }
# data "aws_acm_certificate" "vitiligo_stop_dev_us_east1" {
#   domain   = var.acm_domain
#   provider = aws.us_east_1
# }

# # ALB
# # -----------------
module "alb" {
  source                           = "../../../modules/aws-lb"
  for_each                         = var.alb
  name                             = "${each.key}-${local.prefix}"
  security_groups                  = [module.security_group_alb["security-group-alb"].id]
  subnets                          = [module.subnet["public-subnet-1a"].id, module.subnet["public-subnet-1b"].id]
  enable_cross_zone_load_balancing = lookup(each.value, "enable_cross_zone_load_balancing", null)
  load_balancer_type               = lookup(each.value, "load_balancer_type", null)
  ip_address_type                  = lookup(each.value, "ip_address_type", null)
}

module "alb_ihorse" {
  source                           = "../../../modules/aws-lb"
  for_each                         = var.alb_ihorse
  name                             = "${each.key}-${local.prefix}"
  security_groups                  = [module.security_group_alb["security-group-alb-ihorse"].id]
  subnets                          = [module.subnet["public-subnet-1a"].id, module.subnet["public-subnet-1b"].id]
  enable_cross_zone_load_balancing = lookup(each.value, "enable_cross_zone_load_balancing", null)
  load_balancer_type               = lookup(each.value, "load_balancer_type", null)
  ip_address_type                  = lookup(each.value, "ip_address_type", null)
}

module "alb_voting" {
  source                           = "../../../modules/aws-lb"
  for_each                         = var.alb_voting
  name                             = "${each.key}-${local.prefix}"
  security_groups                  = [module.security_group_alb["security-group-alb-voting"].id]
  subnets                          = [module.subnet["public-subnet-1a"].id, module.subnet["public-subnet-1b"].id]
  enable_cross_zone_load_balancing = lookup(each.value, "enable_cross_zone_load_balancing", null)
  load_balancer_type               = lookup(each.value, "load_balancer_type", null)
  ip_address_type                  = lookup(each.value, "ip_address_type", null)
}


# # ALB Listener
# # ----------------
module "alb_listener_http" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_http
  name              = each.key
  load_balancer_arn = module.alb["alb"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  default_action = [{
    target_group_arn = module.target_group["tg-http"].arn
    type             = lookup(each.value, "type", null)
  }]
}

module "alb_listener_https" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_https
  name              = each.key
  load_balancer_arn = module.alb["alb"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_dev_israel.arn
  default_action = [{
    target_group_arn = module.target_group["tg-http"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group, module.route53_record_cert_approval]
}

module "alb_listener_whm" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_whm
  name              = each.key
  load_balancer_arn = module.alb["alb"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_dev_israel.arn
  default_action = [{
    target_group_arn = module.target_group["tg-whm"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group, module.route53_record_cert_approval]
}

module "alb_listener_2083" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_2083
  name              = each.key
  load_balancer_arn = module.alb["alb"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_dev_israel.arn
  default_action = [{
    target_group_arn = module.target_group["tg-2083"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group, module.route53_record_cert_approval]
}

# ALB Listener Ihorse
# ---------------------------
module "alb_listener_http_ihorse" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_http_ihorse
  name              = each.key
  load_balancer_arn = module.alb_ihorse["alb-ihorse"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  default_action = [{
    target_group_arn = module.target_group_ihorse["ihorse-tg-http"].arn
    type             = lookup(each.value, "type", null)
  }]
}

module "alb_listener_https_ihorse" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_https_ihorse
  name              = each.key
  load_balancer_arn = module.alb_ihorse["alb-ihorse"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_dev_ihorse_israel.arn
  default_action = [{
    target_group_arn = module.target_group_ihorse["ihorse-tg-http"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group_ihorse, module.route53_record_cert_approval_ihorse]
}

module "alb_listener_whm_ihorse" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_whm_ihorse
  name              = each.key
  load_balancer_arn = module.alb_ihorse["alb-ihorse"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_dev_ihorse_israel.arn
  default_action = [{
    target_group_arn = module.target_group_ihorse["ihorse-tg-whm"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group_ihorse, module.route53_record_cert_approval_ihorse]
}

# ALB Listener Voting
# ---------------------------
module "alb_listener_http_voting" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_http_voting
  name              = each.key
  load_balancer_arn = module.alb_voting["alb-voting"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  default_action = [{
    target_group_arn = module.target_group_voting["voting-tg-http"].arn
    type             = lookup(each.value, "type", null)
  }]
}

module "alb_listener_https_voting" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_https_voting
  name              = each.key
  load_balancer_arn = module.alb_voting["alb-voting"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_voting_israel.arn
  default_action = [{
    target_group_arn = module.target_group_voting["voting-tg-http"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group_voting, module.route53_record_cert_approval]
}

module "alb_listener_whm_voting" {
  source            = "../../../modules/aws-lb-listener"
  for_each          = var.alb_listener_whm_voting
  name              = each.key
  load_balancer_arn = module.alb_voting["alb-voting"].arn
  protocol          = lookup(each.value, "protocol", null)
  port              = lookup(each.value, "port", null)
  # certificate_arn   = data.aws_acm_certificate.vitiligo_stop_dev_israel.arn
  certificate_arn = module.acm_certificate_voting_israel.arn
  default_action = [{
    target_group_arn = module.target_group_voting["voting-tg-whm"].arn
    type             = lookup(each.value, "type", null)
  }]
  depends_on = [module.target_group_voting, module.route53_record_cert_approval]
}

# S3 Bucket
# -----------------
module "s3" {
  source   = "../../../modules/s3-bucket"
  for_each = var.s3
  name     = "${each.key}-${local.prefix}"
}


# S3 WebSite
# -----------------
module "s3_website" {
  source                = "../../../modules/s3-website"
  for_each              = var.s3_website
  name                  = "${each.key}-${local.prefix}"
  bucket                = module.s3["s3"].id
  routing_rule          = lookup(each.value, "routing_rule", null)
  expected_bucket_owner = lookup(each.value, "expected_bucket_owner", null)
  index_document        = [{}]
  error_document        = [{}]
}


# VPC Endpoint
# -----------------
module "vpc_endpoint" {
  source              = "../../../modules/vpc-endpoint"
  for_each            = var.vpc_endpoint
  service_name        = lookup(each.value, "service_name", null)
  vpc_endpoint_type   = lookup(each.value, "vpc_endpoint_type", null)
  private_dns_enabled = lookup(each.value, "private_dns_enabled", null)
  vpc_id              = module.vpc["vpc"].id
}

# VPC Endpoint Route Table Association
# -------------------------------------
# module "vpc_endpoint_route_table_association" {
#   source   = "../../../modules/vpc-endpoint-route-table-association"
#   route_table_id  = module.private_route_table["private-route-table"].id
#   vpc_endpoint_id = module.vpc_endpoint["vpc-endpoint"].id
# }


# Route53 Zone
# -----------------
module "route53_zone" {
  source   = "../../../modules/route53-zone"
  for_each = var.route53_zone
  name     = "${each.key}.com"
}
module "route53_zone_dev" {
  source   = "../../../modules/route53-zone"
  for_each = var.route53_zone_dev
  name     = "${var.environment}.${each.key}.com"
}

module "route53_zone_dev_ihorse" {
  source   = "../../../modules/route53-zone"
  for_each = var.route53_zone_dev_ihorse
  name     = "${var.environment}.${each.key}.co.il"
}



# # # Route53 Records
# # # -----------------
# data "aws_route53_zone" "route53_zone_prod" {
#   name = var.dns_zone_prod_name
# }
# For Zone Approval
module "route53_record_zone_approval" {
  source   = "../../../modules/route53-record"
  for_each = var.route53_record_zone_approval
  name     = lookup(each.value, "name", null)
  zone_id  = module.route53_zone["vitiligo-stop"].zone_id
  # zone_id         = data.aws_route53_zone.route53_zone_prod.zone_id
  type            = lookup(each.value, "type", null)
  ttl             = lookup(each.value, "ttl", null)
  allow_overwrite = lookup(each.value, "allow_overwrite", null)
  records = [
    module.route53_zone_dev["vitiligo-stop"].name_servers[0],
    module.route53_zone_dev["vitiligo-stop"].name_servers[1],
    module.route53_zone_dev["vitiligo-stop"].name_servers[2],
    module.route53_zone_dev["vitiligo-stop"].name_servers[3],
  ]
  depends_on = [module.route53_zone_dev]
}
# cPanel A Record
module "route53_record_cpanel" {
  source   = "../../../modules/route53-record"
  for_each = var.route53_record_cpanel
  name     = lookup(each.value, "name", null)
  zone_id  = module.route53_zone_dev["vitiligo-stop"].zone_id
  # zone_id = data.aws_route53_zone.route53_zone_prod.zone_id
  type = lookup(each.value, "type", null)
  alias = [{
    name                   = module.cloudfront_distribution["cloudfront"].domain_name
    zone_id                = module.cloudfront_distribution["cloudfront"].hosted_zone_id
    evaluate_target_health = lookup(each.value, "evaluate_target_health", true)
  }]
  depends_on = [module.route53_zone_dev]
}

# For Cert TLS Approval
locals {
  validation_options = [for dvo in module.acm_certificate_dev_israel.acm_certificate_domain_validation_options : {
    name  = dvo.resource_record_name
    value = dvo.resource_record_value
  }]
}

module "route53_record_cert_approval" {
  source     = "../../../modules/route53-record"
  for_each   = var.route53_record_cert_approval
  name       = local.validation_options[0].name
  records    = [local.validation_options[0].value]
  zone_id    = module.route53_zone_dev["vitiligo-stop"].zone_id
  type       = lookup(each.value, "type", null)
  ttl        = lookup(each.value, "ttl", null)
  depends_on = [module.route53_zone_dev]
}

# # Route53 Records Ihorse
# # ------------------------------
data "aws_route53_zone" "route53_zone_prod_ihorse" {
  name = var.dns_zone_prod_name_ihorse
}
# For Zone Approval
module "route53_record_zone_approval_ihorse" {
  source   = "../../../modules/route53-record"
  for_each = var.route53_record_zone_approval_ihorse
  name     = lookup(each.value, "name", null)
  # zone_id         = module.route53_zone["ihorse"].zone_id
  zone_id         = data.aws_route53_zone.route53_zone_prod_ihorse.zone_id
  type            = lookup(each.value, "type", null)
  ttl             = lookup(each.value, "ttl", null)
  allow_overwrite = lookup(each.value, "allow_overwrite", null)
  records = [
    module.route53_zone_dev_ihorse["ihorse"].name_servers[0],
    module.route53_zone_dev_ihorse["ihorse"].name_servers[1],
    module.route53_zone_dev_ihorse["ihorse"].name_servers[2],
    module.route53_zone_dev_ihorse["ihorse"].name_servers[3],
  ]
  depends_on = [module.route53_zone_dev_ihorse]
}

# cPanel A Record
module "route53_record_cpanel_ihorse" {
  source   = "../../../modules/route53-record"
  for_each = var.route53_record_cpanel_ihorse
  name     = lookup(each.value, "name", null)
  zone_id  = module.route53_zone_dev_ihorse["ihorse"].zone_id
  # zone_id = data.aws_route53_zone.route53_zone_prod.zone_id
  type = lookup(each.value, "type", null)
  alias = [{
    name                   = module.cloudfront_distribution_ihorse["cloudfront-ihorse"].domain_name
    zone_id                = module.cloudfront_distribution_ihorse["cloudfront-ihorse"].hosted_zone_id
    evaluate_target_health = lookup(each.value, "evaluate_target_health", true)
  }]
  depends_on = [module.route53_zone_dev_ihorse]
}

# For Cert TLS Approval
locals {
  validation_optionss = [for dvo in module.acm_certificate_dev_ihorse_israel.acm_certificate_domain_validation_options : {
    name  = dvo.resource_record_name
    value = dvo.resource_record_value
  }]
}

module "route53_record_cert_approval_ihorse" {
  source     = "../../../modules/route53-record"
  for_each   = var.route53_record_cert_approval_ihorse
  name       = local.validation_optionss[0].name
  records    = [local.validation_optionss[0].value]
  zone_id    = module.route53_zone_dev_ihorse["ihorse"].zone_id
  type       = lookup(each.value, "type", null)
  ttl        = lookup(each.value, "ttl", null)
  depends_on = [module.route53_zone_dev_ihorse]
}

# # # Cloudfront Distribution
# # # ------------------------
module "cloudfront_distribution" {
  source                 = "../../../modules/cloudfront-distribution"
  for_each               = var.cloudfront_distribution
  name                   = "${each.key}-${local.prefix}"
  enabled                = lookup(each.value, "enabled", null)
  price_class            = lookup(each.value, "price_class", null)
  is_ipv6_enabled        = lookup(each.value, "is_ipv6_enabled", null)
  default_root_object    = lookup(each.value, "default_root_object", null)
  geo_restriction        = lookup(each.value, "geo_restriction", {})
  default_cache_behavior = lookup(each.value, "default_cache_behavior", {})
  forwarded_values       = lookup(each.value, "forwarded_values", {})
  custom_origin_config   = lookup(each.value, "custom_origin_config", {})
  restrictions           = lookup(each.value, "restrictions", {})
  web_acl_id             = module.wafv2_acl["waf"].arn
  target_origin_id       = lookup(each.value, "target_origin_id", null)
  aliases                = lookup(each.value, "aliases", null)
  origin = [{
    domain_name = module.alb["alb"].dns_name
    origin_id   = lookup(each.value, "origin_id", null)
  }]
  viewer_certificate = [{
    # cloudfront_default_certificate = lookup(each.value, "cloudfront_default_certificate", true)
    ssl_support_method  = lookup(each.value, "ssl_support_method", "sni-only")
    acm_certificate_arn = module.acm_certificate_dev_us_east1.arn
    # acm_certificate_arn = data.aws_acm_certificate.binna_dev_us_east1.arn
  }]
  depends_on = [module.alb, module.acm_certificate_dev_us_east1]
  providers = {
    aws = aws.us_east_1
  }
}

module "cloudfront_distribution_ihorse" {
  source                 = "../../../modules/cloudfront-distribution"
  for_each               = var.cloudfront_distribution_ihorse
  name                   = "${each.key}-${local.prefix}"
  enabled                = lookup(each.value, "enabled", null)
  price_class            = lookup(each.value, "price_class", null)
  is_ipv6_enabled        = lookup(each.value, "is_ipv6_enabled", null)
  default_root_object    = lookup(each.value, "default_root_object", null)
  geo_restriction        = lookup(each.value, "geo_restriction", {})
  default_cache_behavior = lookup(each.value, "default_cache_behavior", {})
  forwarded_values       = lookup(each.value, "forwarded_values", {})
  custom_origin_config   = lookup(each.value, "custom_origin_config", {})
  restrictions           = lookup(each.value, "restrictions", {})
  web_acl_id             = module.wafv2_acl["waf-ihorse"].arn
  target_origin_id       = lookup(each.value, "target_origin_id", null)
  aliases                = lookup(each.value, "aliases", null)
  origin = [{
    domain_name = module.alb_ihorse["alb-ihorse"].dns_name
    origin_id   = lookup(each.value, "origin_id", null)
  }]
  viewer_certificate = [{
    ssl_support_method  = lookup(each.value, "ssl_support_method", "sni-only")
    acm_certificate_arn = module.acm_certificate_dev_ihorse_us_east1.arn
  }]
  depends_on = [module.alb_ihorse, module.acm_certificate_dev_ihorse_us_east1]
  providers = {
    aws = aws.us_east_1
  }
}

module "cloudfront_distribution_voting" {
  source                 = "../../../modules/cloudfront-distribution"
  for_each               = var.cloudfront_distribution_voting
  name                   = "${each.key}-${local.prefix}"
  enabled                = lookup(each.value, "enabled", null)
  price_class            = lookup(each.value, "price_class", null)
  is_ipv6_enabled        = lookup(each.value, "is_ipv6_enabled", null)
  default_root_object    = lookup(each.value, "default_root_object", null)
  geo_restriction        = lookup(each.value, "geo_restriction", {})
  default_cache_behavior = lookup(each.value, "default_cache_behavior", {})
  forwarded_values       = lookup(each.value, "forwarded_values", {})
  custom_origin_config   = lookup(each.value, "custom_origin_config", {})
  restrictions           = lookup(each.value, "restrictions", {})
  web_acl_id             = module.wafv2_acl["waf-voting"].arn
  target_origin_id       = lookup(each.value, "target_origin_id", null)
  aliases                = lookup(each.value, "aliases", null)
  origin = [{
    domain_name = module.alb_voting["alb-voting"].dns_name
    origin_id   = lookup(each.value, "origin_id", null)
  }]
  viewer_certificate = [{
    ssl_support_method  = lookup(each.value, "ssl_support_method", "sni-only")
    acm_certificate_arn = module.acm_certificate_voting_us_east1.arn
  }]
  depends_on = [module.alb_voting, module.acm_certificate_voting_us_east1]
  providers = {
    aws = aws.us_east_1
  }
}

# # WAF ACL
# # -----------------
module "wafv2_acl" {
  source            = "../../../modules/wafv2_acl"
  for_each          = var.wafv2_acl
  name              = "${each.key}-${local.prefix}"
  scope             = lookup(each.value, "scope", null)
  default_action    = lookup(each.value, "default_action", {})
  visibility_config = lookup(each.value, "visibility_config", {})
  rule              = lookup(each.value, "rule", {})
  action            = lookup(each.value, "action", {})
  statement         = lookup(each.value, "statement", {})
  country_codes     = lookup(each.value, "country_codes", [])
  providers = {
    aws = aws.us_east_1
  }
}


# # WAF IP Set
# # -----------------
# module "wafv2_ip_set" {
#   source             = "../../../modules/wafv2-ip-set"
#   for_each           = var.wafv2_ip_set
#   name               = each.key
#   scope              = lookup(each.value, "scope", null)
#   ip_address_version = lookup(each.value, "ip_address_version", null)
#   addresses          = lookup(each.value, "addresses", null)
# }
