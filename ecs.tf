resource "aws_ecs_cluster" "devops1" {
  name = "devops1-cluster"
  tags = var.tags
}