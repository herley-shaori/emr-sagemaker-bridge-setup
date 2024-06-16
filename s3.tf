resource "aws_s3_bucket" "emr_bucket" {
  bucket = local.bucket_name
}

resource "aws_s3_object" "bootstrap_script" {
  bucket = aws_s3_bucket.emr_bucket.bucket
  key    = "bootstrap/general-bootstrap.sh"
  source = "${path.module}/emr-bootstrap-script/general-bootstrap.sh"
}

resource "aws_s3_object" "cloudformation_template" {
  bucket = aws_s3_bucket.emr_bucket.bucket
  key    = "templates/emr_cluster_template.yaml"
  source = "${path.module}/service-catalog-cloudformation/emr_sagemaker_bridge_base_deploy.yaml"
  tags = {
    Name = "EMR CloudFormation Template"
  }
}