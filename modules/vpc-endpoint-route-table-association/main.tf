resource "aws_vpc_endpoint_route_table_association" "vpc_endpoint_route_table_association" {
  route_table_id  = var.route_table_id
  vpc_endpoint_id = var.vpc_endpoint_id
}