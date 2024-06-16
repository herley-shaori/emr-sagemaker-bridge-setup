resource "aws_servicecatalog_portfolio" "emr_portfolio" {
  name          = "EMR Portfolio"
  description   = "Portfolio for EMR CloudFormation templates"
  provider_name = "MyCompany"
  tags = {
    Name = "EMR Portfolio"
  }
}

resource "aws_servicecatalog_product" "emr_product" {
  name          = "EMR Cluster"
  owner         = "MyCompany"
  description   = "CloudFormation template to deploy an EMR Cluster"
  distributor   = "MyCompany"
  support_email = "herley.shaori@gmail.com"
  type          = "CLOUD_FORMATION_TEMPLATE"
  provisioning_artifact_parameters {
    name        = "v1"
    description = "Version 1"
    template_url = "https://${aws_s3_bucket.emr_bucket.bucket}.s3.amazonaws.com/templates/emr_cluster_template.yaml"
    type        = "CLOUD_FORMATION_TEMPLATE"
  }
  tags = {
    Name = "EMR Cluster Product"
    "sagemaker:studio-visibility:emr" = true
  }
}

resource "aws_servicecatalog_product_portfolio_association" "emr_portfolio_product_association" {
  portfolio_id = aws_servicecatalog_portfolio.emr_portfolio.id
  product_id   = aws_servicecatalog_product.emr_product.id
}

resource "aws_servicecatalog_principal_portfolio_association" "emr_portfolio_association" {
  portfolio_id  = aws_servicecatalog_portfolio.emr_portfolio.id
  principal_arn = data.aws_caller_identity.current.arn
}

resource "aws_servicecatalog_principal_portfolio_association" "emr_portfolio_association_for_role" {
  portfolio_id  = aws_servicecatalog_portfolio.emr_portfolio.id
  principal_arn = aws_iam_role.sagemaker_execution_role.arn
}

data "aws_caller_identity" "current" {}