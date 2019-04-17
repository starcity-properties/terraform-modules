resource "aws_instance" "bastion" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_id}"

  tags {
    Name = "bastion-${var.environment}"
  }
}

resource "aws_security_group" "bastion-sg" {
  description = "Allow SSH access to bastion host from specific source IPs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["199.188.195.215/32", "73.15.166.45/32", "104.193.169.148/32", "41.90.125.50/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags {
    Name = "bastion-sg-${var.environment}"
  }
}