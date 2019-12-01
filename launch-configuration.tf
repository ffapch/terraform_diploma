resource "aws_launch_configuration" "launch-configuration" {
  name                        = "dev1-launch-configuration"
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