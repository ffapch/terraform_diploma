resource "aws_alb_target_group" "nginx-target-group" {
  name     = "dev1-nginx-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "8"
    interval            = "20"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "15"
  }

  tags = var.tags
}

resource "aws_alb_target_group" "app-target-group" {
  name     = "dev1-app-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "8"
    interval            = "20"
    matcher             = "200"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "15"
  }

  tags = var.tags
}