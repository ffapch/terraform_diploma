resource "aws_alb" "ecs-alb" {
  name            = "dev1-ecs-alb"
  security_groups = [aws_security_group.main.id]
  subnets         = [module.subnet1.subnet_id, module.subnet2.subnet_id]
  tags            = var.tags
}

resource "aws_alb_listener" "alb-nginx-listener" {
  load_balancer_arn = aws_alb.ecs-alb.id
  port              = 8080
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.nginx-target-group.id
    type             = "forward"
  }
}

resource "aws_alb_listener" "alb-app-listener" {
  load_balancer_arn = aws_alb.ecs-alb.id
  port              = 1234
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app-target-group.id
    type             = "forward"
  }
}