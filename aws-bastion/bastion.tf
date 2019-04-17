##########
# Bastion
##########
resource "aws_instance" "bastion" {
  ami             = "${var.ami}"
  instance_type   = "${var.instance_type}"
  subnet_id       = "${var.subnet_id}"
  key_name        = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.bastion-sg.id}"]

  tags {
    Name = "bastion-${var.environment}"
  }
}

resource "aws_security_group" "bastion-sg" {
  vpc_id      = "${var.vpc_id}"
  description = "Allow SSH access to bastion host from specific source IPs"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = "${var.bastion_cidr_blocks}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bastion-sg-${var.environment}"
  }
}

resource "aws_eip" "bastion" {
  vpc      = true
  instance = "${aws_instance.bastion.id}"
}
