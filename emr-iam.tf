resource "aws_iam_role" "emr_service_role" {
  name = "EMR_ServiceRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "elasticmapreduce.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = {
    Name = "EMR Service Role"
  }
}

resource "aws_iam_role_policy_attachment" "emr_service_role_policy" {
  role       = aws_iam_role.emr_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceRole"
}

resource "aws_iam_role" "emr_job_flow_role" {
  name = "EMR_JobFlowRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "EMR Job Flow Role"
  }
}

resource "aws_iam_instance_profile" "emr_instance_profile" {
  name = "EMR_EC2_InstanceProfile"
  role = aws_iam_role.emr_job_flow_role.name
}

resource "aws_iam_role_policy_attachment" "emr_job_flow_role_policy" {
  role       = aws_iam_role.emr_job_flow_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonElasticMapReduceforEC2Role"
}