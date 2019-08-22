# EC2 Instance
resource "aws_instance" "aws-ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  iam_instance_profile   = var.iam_instance_profile
  subnet_id              = element(var.public_subnet_id, 0)
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.aws-sg.id]

  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.application}-${var.environment}"
  }
}

# EC2 Security Group
resource "aws_security_group" "aws-sg" {
  name        = "${var.application}-sg-${var.environment}"
  vpc_id      = var.vpc_id
  description = "Security group that allows incoming traffic from Bastion and ALB only"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.ssh_cidr
  }

  ingress {
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.application}-sg-${var.environment}"
  }
}

# Elastic IP
resource "aws_eip" "aws-eip" {
  instance = aws_instance.aws-ec2.id
  vpc      = true
}

