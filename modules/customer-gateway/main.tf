resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = var.bgp_asn
  ip_address = var.ip_address
  type       = var.type
  certificate_arn = var.certificate_arn
  device_name = var.device_name

  tags = merge(
    { "Name" = "${var.name}" },
    var.tags,
  )
}