resource "aws_ecs_cluster" "devops1" {
  name = "devops1-cluster"
  tags = var.tags
}

resource "aws_ecs_task_definition" "td1" {
  family                = "td1"
  cpu                   = 128
  memory                = 256
  container_definitions = <<EOF
[{
  "name": "td1",
  "image": "nginx:latest",
  "cpu": 10,
  "memory": 256,
  "memoryReservation": 128,
  "essential": true,
  "portMappings": [{
    "hostPort": 8080,
    "containerPort": 80,
    "protocol": "tcp"
  }]
}]
EOF
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.devops1.id
  desired_count   = 2
  task_definition = aws_ecs_task_definition.td1.id

  load_balancer {
    container_name   = "td1"
    container_port   = 80
    target_group_arn = aws_alb_target_group.ecs-target-group.id
  }
}