variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "ig_id" {
  type = string
}

variable "availability_zone_name" {
  type = string
}

variable "aws_route_table_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = { Name = "dev1", Description = "Managed by terraform" }
}