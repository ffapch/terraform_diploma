variable "cluster_id" {
  type = string
}

variable "desired_count" {
  type = number
  default = 1
}

variable "task_definition_id" {
  type = string
}

variable "name" {
  type = string
}

variable "load_balancer_container_name" {
  type = string
}

variable "load_balancer_container_port" {
  type = number
}

variable "load_balancer_target_group_id" {
  type = string
}