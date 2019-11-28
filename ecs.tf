locals {
  nginx_service_name = "dev1-nginx"
  app_service_name   = "dev1-app"
}

resource "aws_ecs_cluster" "devops1" {
  name = "devops1-cluster"
  tags = var.tags
}

//resource "aws_ecs_task_definition" "dev1-nginx-td" {
//  family                = "${local.nginx_service_name}-td"
//  cpu                   = 128
//  memory                = 256
//  container_definitions = <<EOF
//[{
//  "name": "${local.nginx_service_name}",
//  "image": "nginx:latest",
//  "cpu": 10,
//  "memory": 256,
//  "memoryReservation": 128,
//  "essential": true,
//  "portMappings": [{
//    "hostPort": 8080,
//    "containerPort": 80,
//    "protocol": "tcp"
//  }]
//}]
//EOF
//}

resource "aws_ecs_task_definition" "dev1-app-td" {
  family                = "${local.app_service_name}-td"
  cpu                   = 128
  memory                = 256
  container_definitions = <<EOF
[{
  "name": "${local.app_service_name}",
  "image": "ffapch/webapp:1.0",
  "cpu": 10,
  "memory": 256,
  "memoryReservation": 128,
  "essential": true,
  "portMappings": [{
    "hostPort": 1234,
    "containerPort": 80,
    "protocol": "tcp"
  }]
}]
EOF
}

//module "ecs_service_nginx" {
//  source                        = "./ecs_service"
//  name                          = local.nginx_service_name
//  cluster_id                    = aws_ecs_cluster.devops1.id
//  desired_count                 = 1
//  task_definition_id            = aws_ecs_task_definition.dev1-nginx-td.id
//  load_balancer_container_name  = local.nginx_service_name
//  load_balancer_container_port  = 80
//  load_balancer_target_group_id = module.target_group_nginx.target_group_id
//}

module "ecs_service_app" {
  source                        = "./ecs_service"
  name                          = local.app_service_name
  cluster_id                    = aws_ecs_cluster.devops1.id
  desired_count                 = 1
  task_definition_id            = aws_ecs_task_definition.dev1-app-td.id
  load_balancer_container_name  = local.app_service_name
  load_balancer_container_port  = 80
  load_balancer_target_group_id = module.target_group_app.target_group_id
}

//resource "aws_ecs_service" "nginx" {
//  name            = "nginx"
//  cluster         = aws_ecs_cluster.devops1.id
//  desired_count   = 1
//  task_definition = aws_ecs_task_definition.dev1-td-nginx.id
//
//  load_balancer {
//    container_name   = "dev1-td-nginx"
//    container_port   = 80
//    target_group_arn = module.target_group_nginx.target_group_id
//  }
//}

//resource "aws_ecs_service" "app" {
//  name            = "app"
//  cluster         = aws_ecs_cluster.devops1.id
//  desired_count   = 1
//  task_definition = aws_ecs_task_definition.dev1-td-app.id
//
//  load_balancer {
//    container_name   = "dev1-td-app"
//    container_port   = 80
//    target_group_arn = module.target_group_app.target_group_id
//  }
//}