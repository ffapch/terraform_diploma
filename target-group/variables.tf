variable "alb_id" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
  default = "HTTP"
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
  default = { Name = "dev1", Description = "Managed by terraform" }
}