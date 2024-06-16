# Create a SageMaker User Profile
resource "aws_sagemaker_user_profile" "user_profile" {
  domain_id         = aws_sagemaker_domain.domain.id
  user_profile_name = var.sagemaker_user_name

  user_settings {
    execution_role  = aws_iam_role.sagemaker_execution_role.arn
  }
  tags = {
    Name            = var.sagemaker_user_name
  }
}