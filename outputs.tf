output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "sagemaker_domain_id" {
  description = "The ID of the SageMaker domain"
  value       = aws_sagemaker_domain.domain.id
}

output "sagemaker_user_profile_id" {
  description = "The ID of the SageMaker user profile"
  value       = aws_sagemaker_user_profile.user_profile.id
}

output "bootstrap_script_s3_path" {
  description = "The S3 path to the bootstrap script"
  value       = "s3://${aws_s3_bucket.emr_bucket.bucket}/bootstrap/general-bootstrap.sh"
}

output "cloudformation_template_url" {
  description = "The S3 URL of the CloudFormation template"
  value       = "https://${aws_s3_bucket.emr_bucket.bucket}.s3.amazonaws.com/templates/emr_cluster_template.yaml"
}

output "sagemaker_domain_subnet" {
  description = "SageMaker subnet."
  value       = aws_sagemaker_domain.domain.subnet_ids
}

output "sagemaker_domain_security_group" {
  description = "SageMaker subnet."
  value       = aws_sagemaker_domain.domain.security_group_id_for_domain_boundary
}