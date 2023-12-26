resource "aws_wafv2_ip_set" "wafv2_ip_set" {
  name               = var.name
  scope              = var.scope
  description        = var.description
  ip_address_version = var.ip_address_version
  addresses          = var.addresses

  tags = merge(
    { "Name" = "${var.name}" },
    var.tags,
  )
}
