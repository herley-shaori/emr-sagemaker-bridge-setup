# Configure the AWS provider
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      environment = "DEV"
      project     = "setup-sagemaker-emr-bridge"
    }
  }
}