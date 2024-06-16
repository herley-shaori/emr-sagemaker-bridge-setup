# Create a SageMaker Domain
resource "aws_sagemaker_domain" "domain" {
  domain_name           = var.sagemaker_domain_name
  auth_mode             = "IAM"
  default_user_settings {
    execution_role      = aws_iam_role.sagemaker_execution_role.arn
    security_groups     = [aws_security_group.main.id]
  }
  subnet_ids            = [aws_subnet.private.id]
  vpc_id                = aws_vpc.main.id

  tags = {
    Name = var.sagemaker_domain_name
  }
}

# Create an IAM role for SageMaker execution
resource "aws_iam_role" "sagemaker_execution_role" {
  name = "${var.sagemaker_domain_name}-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sagemaker.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.sagemaker_domain_name}-execution-role"
  }
}

resource "aws_iam_role_policy" "sagemaker_execution_policy" {
  name = "${var.sagemaker_domain_name}-execution-policy"
  role = aws_iam_role.sagemaker_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sagemaker:*",
          "s3:*",
          "ecr:*",
          "cloudwatch:*",
          "logs:*",
          "ec2:Describe*",
          "iam:PassRole",
          "servicecatalog:*",
          "cloudformation:*",
          "elasticmapreduce:*",
          "iam:CreateServiceLinkedRole"
        ],
        Resource = "*"
      }
    ]
  })
}