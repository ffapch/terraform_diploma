resource "aws_subnet" "this" {
  cidr_block = var.cidr_block
  vpc_id = var.vpc_id
  availability_zone = var.availability_zone_name
  map_public_ip_on_launch = true
  tags = var.tags
}

resource "aws_route_table_association" "this" {
  route_table_id = var.aws_route_table_id
  subnet_id = aws_subnet.this.id
}
