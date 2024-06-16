# Create a security group
resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project_name}-sg"
  # Inbound rule to allow traffic within the VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow traffic from created VPC."
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1" # -1 means all protocols
    self            = true
    description     = "Allow traffic from itself."
  }

  ingress {
    from_port   = 10000
    to_port     = 10000
    protocol    = "TCP" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Livy."
  }

  ingress {
    from_port   = 8889
    to_port     = 8889
    protocol    = "TCP" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Livy."
  }

  # Outbound rule to allow all traffic to the world
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic to the world."
  }

  tags = {
    Name = "SageMaker-EMR bridge."
  }
}

# Create a security group
resource "aws_security_group" "secondary_sg" {
  vpc_id = aws_vpc.main.id
  name   = "${var.project_name}-secondary-sg"
  # Inbound rule to allow traffic within the VPC
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Allow traffic from created VPC."
  }

  ingress {
    from_port   = 10000
    to_port     = 10000
    protocol    = "TCP" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Livy."
  }

  ingress {
    from_port   = 8889
    to_port     = 8889
    protocol    = "TCP" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow Livy."
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1" # -1 means all protocols
    self            = true
    description     = "Allow traffic from itself."
  }

  # Outbound rule to allow all traffic to the world
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow traffic to the world."
  }

  tags = {
    Name = "SageMaker-EMR bridge."
  }
}

# Add ingress rule to allow traffic from secondary_sg to main
resource "aws_security_group_rule" "allow_secondary_to_main" {
  type              = "ingress"
  from_port         = 9443
  to_port           = 9443
  protocol          = "TCP" # -1 means all protocols
  security_group_id = aws_security_group.main.id
  source_security_group_id = aws_security_group.secondary_sg.id
  description       = "Allow traffic from secondary security group."
}

# Add ingress rule to allow traffic from main to secondary_sg
resource "aws_security_group_rule" "allow_main_to_secondary" {
  type              = "ingress"
  from_port         = 9443
  to_port           = 9443
  protocol          = "TCP" # -1 means all protocols
  security_group_id = aws_security_group.secondary_sg.id
  source_security_group_id = aws_security_group.main.id
  description       = "Allow traffic from main security group."
}

# Add ingress rule to allow traffic from secondary_sg to main
resource "aws_security_group_rule" "allow_secondary_to_main_2" {
  type              = "ingress"
  from_port         = 8998
  to_port           = 8998
  protocol          = "TCP" # -1 means all protocols
  security_group_id = aws_security_group.main.id
  source_security_group_id = aws_security_group.main.id
}
resource "aws_security_group_rule" "allow_secondary_to_main_3" {
  type              = "ingress"
  from_port         = 10000
  to_port           = 10000
  protocol          = "TCP" # -1 means all protocols
  security_group_id = aws_security_group.main.id
  source_security_group_id = aws_security_group.main.id
}
resource "aws_security_group_rule" "allow_secondary_to_main_4" {
  type              = "ingress"
  from_port         = 8889
  to_port           = 8889
  protocol          = "TCP" # -1 means all protocols
  security_group_id = aws_security_group.main.id
  source_security_group_id = aws_security_group.main.id
}

# Add ingress rule to allow traffic from main to secondary_sg
resource "aws_security_group_rule" "allow_main_to_secondary_2" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = -1 # -1 means all protocols
  security_group_id = aws_security_group.secondary_sg.id
  source_security_group_id = aws_security_group.main.id
  description       = "Allow traffic from main security group."
}