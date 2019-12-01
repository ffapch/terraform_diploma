resource "aws_autoscaling_group" "autoscaling-group" {
  name                 = "dev1-autoscaling-group"
  max_size             = 4
  min_size             = 2
  desired_capacity     = 2
  health_check_grace_period = 300
  vpc_zone_identifier  = [module.subnet1.subnet_id, module.subnet2.subnet_id]
  launch_configuration = aws_launch_configuration.launch-configuration.name
  target_group_arns    = [aws_alb_target_group.app-target-group.id, aws_alb_target_group.nginx-target-group.id]
  health_check_type    = "ELB"

  lifecycle {
    create_before_destroy = true
  }
}