# Define variables for region and default tags
variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-southeast-3"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/25"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.0.128/25"
}

variable "project_name" {
  type        = string
  default     = "SageMaker EMR Bridge"
}

variable "sagemaker_domain_name" {
  description = "The name of the SageMaker domain"
  type        = string
  default     = "sagemaker-emr-sample-domain"
}

variable "sagemaker_user_name" {
  description = "The name of the SageMaker user"
  type        = string
  default     = "herley"
}

variable "bootstrap_script_path" {
  description = "Local path to the bootstrap script"
  type        = string
  default     = "path/to/general-bootstrap.sh"
}