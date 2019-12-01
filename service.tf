locals {
  nginx_service_name = "dev1-nginx"
  app_service_name   = "dev1-app"
}

resource "aws_ecs_task_definition" "dev1-nginx-td" {
  family                = "${local.nginx_service_name}-td"
  cpu                   = 128
  memory                = 256
  container_definitions = file("task-definitions/nginx.json")
}

resource "aws_ecs_task_definition" "dev1-app-td" {
  family                = "${local.app_service_name}-td"
  cpu                   = 128
  memory                = 256
  container_definitions = file("task-definitions/app.json")
}

//resource "aws_ecs_task_definition" "dev1-app-db-migration-td" {
//  family                = "${local.app_service_name}-db-migration-td"
//  cpu                   = 128
//  memory                = 128
//  container_definitions = file("task-definitions/dbmigration.json")
//}

resource "aws_ecs_service" "nginx" {
  name            = local.nginx_service_name
  cluster         = aws_ecs_cluster.devops1.id
  desired_count   = 2
  task_definition = aws_ecs_task_definition.dev1-nginx-td.id

  load_balancer {
    container_name   = local.nginx_service_name
    container_port   = 80
    target_group_arn = aws_alb_target_group.nginx-target-group.id
  }
}

resource "aws_ecs_service" "app" {
  name            = local.app_service_name
  cluster         = aws_ecs_cluster.devops1.id
  desired_count   = 2
  task_definition = aws_ecs_task_definition.dev1-app-td.id

  load_balancer {
    container_name   = local.app_service_name
    container_port   = 80
    target_group_arn = aws_alb_target_group.app-target-group.id
  }
}