locals {
  bucket_name             = "emr-sagemaker-bridge-artifacts-jddgkjg08n9u3kn"
  log_uri                 = "s3://${local.bucket_name}/elasticmapreduce"
  cloudformation_template = templatefile("${path.module}/service-catalog-cloudformation/emr_sagemaker_bridge_base_deploy.yaml", {
    BootstrapScriptS3Path = "s3://${aws_s3_bucket.emr_bucket.bucket}/templates/emr_cluster_template.yaml"
  })
    }