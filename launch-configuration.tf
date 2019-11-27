resource "aws_launch_configuration" "ecs-launch-configuration" {
  name                        = "dev1-ecs-launch-configuration"
  image_id                    = "ami-020c0a39d62d1ee78"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.main.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.dev1-ecs-instance-profile.id
  key_name                    = "dev_1"
  user_data                   = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.devops1.name} >> /etc/ecs/ecs.config
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs-autoscaling-group" {
  name                 = "dev1-autoscaling-group"
  max_size             = 1
  min_size             = 1
  desired_capacity     = 1
  vpc_zone_identifier  = [module.subnet1.subnet_id, module.subnet2.subnet_id]
  launch_configuration = aws_launch_configuration.ecs-launch-configuration.name
  target_group_arns    = [aws_alb_target_group.ecs-target-group.id]
  health_check_type    = "ELB"


  lifecycle {
    create_before_destroy = true
  }
}