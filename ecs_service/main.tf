resource "aws_ecs_service" "this" {
  name            = var.name
  cluster         = var.cluster_id
  desired_count   = var.desired_count
  task_definition = var.task_definition_id

  load_balancer {
    container_name   = var.load_balancer_container_name
    container_port   = var.load_balancer_container_port
    target_group_arn = var.load_balancer_target_group_id
  }
}