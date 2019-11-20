resource "aws_subnet" "this" {
  cidr_block = var.cidr_block
  vpc_id = var.vpc_id
  tags = var.tags
}

resource "aws_route_table" "this" {
  vpc_id = var.vpc_id
  tags = var.tags
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.ig_id
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id = aws_subnet.this.id
}
