variable "vpc_id" {
  type = string
}

variable "cidr_block" {
  type = string
}

variable "ig_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = { Name = "dev1", Description = "Managed by terraform" }
}