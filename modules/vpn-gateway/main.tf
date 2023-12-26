resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = var.vpc_id
  availability_zone = var.availability_zone 
  amazon_side_asn = var.amazon_side_asn


  tags = merge(
    { "Name" = "${var.name}" },
    var.tags,
  )
}