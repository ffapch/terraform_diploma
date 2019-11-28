resource "aws_alb_listener" "this" {
  load_balancer_arn = var.alb_id
  port              = var.port
  protocol          = var.protocol

  default_action {
    target_group_arn = aws_alb_target_group.this.id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "this" {
  name_prefix = "dev1-"
  port     = var.port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = "3"
    unhealthy_threshold = "5"
    interval            = "30"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "10"
  }

  tags = var.tags
}