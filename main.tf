resource "aws_internet_gateway" "ig_public" {
  vpc_id = aws_vpc.main.id
  tags = var.tags
}

module "subnet1" {
  source = "./subnet"
  cidr_block = "10.0.0.0/25"
  vpc_id = aws_vpc.main.id
  ig_id = aws_internet_gateway.ig_public.id
  tags = var.tags
}

module "subnet2" {
  source = "./subnet"
  cidr_block = "10.0.0.128/25"
  vpc_id = aws_vpc.main.id
  ig_id = aws_internet_gateway.ig_public.id
  tags = var.tags
}
