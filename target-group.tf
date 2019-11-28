//module "target_group_nginx" {
//  source = "./target-group"
//  alb_id = aws_alb.ecs-alb.id
//  port   = 8080
//  vpc_id = aws_vpc.main.id
//  tags   = var.tags
//}

module "target_group_app" {
  source = "./target-group"
  alb_id = aws_alb.ecs-alb.id
  port   = 1234
  vpc_id = aws_vpc.main.id
  tags   = var.tags
}