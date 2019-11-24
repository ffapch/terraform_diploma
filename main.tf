resource "aws_internet_gateway" "ig_public" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags   = var.tags
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_public.id
  }
}

module "subnet1" {
  source                 = "./subnet"
  cidr_block             = "10.0.0.0/25"
  vpc_id                 = aws_vpc.main.id
  ig_id                  = aws_internet_gateway.ig_public.id
  availability_zone_name = data.aws_availability_zones.available.names[0]
  aws_route_table_id     = aws_route_table.public.id
  tags                   = var.tags
}

module "subnet2" {
  source                 = "./subnet"
  cidr_block             = "10.0.0.128/25"
  vpc_id                 = aws_vpc.main.id
  ig_id                  = aws_internet_gateway.ig_public.id
  availability_zone_name = data.aws_availability_zones.available.names[1]
  aws_route_table_id     = aws_route_table.public.id
  tags                   = var.tags
}
