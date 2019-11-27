resource "aws_iam_instance_profile" "dev1-ecs-instance-profile" {
  name = "dev1-ecs-instance-profile"
  role = aws_iam_role.dev1-iam-role.name
}

resource "aws_iam_role" "dev1-iam-role" {
  name               = "dev1-iam-role"
  assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": {
            "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
        }
      ]
}
EOF
}

resource "aws_iam_policy" "dev1-ec2-container-policy" {
  name        = "dev1-ec2-container-policy"
  description = "AmazonEC2ContainerServiceforEC2Role"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeTags",
                "ecs:DeregisterContainerInstance",
                "ecs:DiscoverPollEndpoint",
                "ecs:Poll",
                "ecs:RegisterContainerInstance",
                "ecs:StartTelemetrySession",
                "ecs:UpdateContainerInstancesState",
                "ecs:Submit*",
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "dev1-attach" {
  role       = aws_iam_role.dev1-iam-role.name
  policy_arn = aws_iam_policy.dev1-ec2-container-policy.arn
}