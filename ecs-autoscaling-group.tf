resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  name                 = "dev1-autoscaling-group"
  max_size             = 4
  min_size             = 2
  desired_capacity     = 4
  vpc_zone_identifier  = [module.subnet1.subnet_id, module.subnet2.subnet_id]
  launch_configuration = aws_launch_configuration.ecs-launch-configuration.name
  target_group_arns    = [module.target_group_nginx.target_group_id, module.target_group_app.target_group_id]
  health_check_type    = "ELB"


  lifecycle {
    create_before_destroy = true
  }
}