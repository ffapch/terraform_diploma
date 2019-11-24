variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "aws_profile" {
  type    = string
  default = "753788210905"
}

variable "tags" {
  type    = map(string)
  default = { Name = "dev1", Description = "Managed by terraform" }
}