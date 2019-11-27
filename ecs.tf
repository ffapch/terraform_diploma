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
    "hostPort": 0,
    "containerPort": 8080,
    "protocol": "tcp"
  }]
}]
EOF
}

resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.devops1.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.td1.id

  //iam_role = aws_iam_role.dev1-iam-role.id

  load_balancer {
    container_name   = "td1"
    container_port   = 8080
    target_group_arn = aws_alb_target_group.ecs-target-group.id
  }
}