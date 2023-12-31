resource "aws_vpc_ipv4_cidr_block_association" "this" {
  for_each            = var.create ? toset(["block_association"]) : toset([])
  vpc_id              = var.vpc_id
  cidr_block          = var.cidr_block
  ipv4_ipam_pool_id   = var.ipv4_ipam_pool_id
  ipv4_netmask_length = var.ipv4_ipam_pool_id != null ? var.ipv4_netmask_length : null
}
