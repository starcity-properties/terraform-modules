# RDS Instance
resource "aws_db_instance" "rds" {
  identifier             = "${var.application}-db-${var.environment}"
  allocated_storage      = "${var.allocated_storage}"
  storage_type           = "${var.storage_type}"
  engine                 = "${var.engine}"
  engine_version         = "${var.engine_version}"
  instance_class         = "${var.instance_class}"
  name                   = "${var.name}"
  username               = "${var.username}"
  password               = "${var.password}"
  db_subnet_group_name   = "${aws_db_subnet_group.rds-subnet-group.name}"
  vpc_security_group_ids = ["${aws_security_group.rds-sg.id}"]
  skip_final_snapshot    = true
  deletion_protection    = true
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "${var.application}-rds-subnet-group-${var.environment}"
  subnet_ids = ["${var.private_subnet_id}"]

  tags = {
    Name = "${var.application}-rds-subnet-group-${var.environment}"
  }
}

# RDS Security Group
resource "aws_security_group" "rds-sg" {
  name        = "${var.application}-rds-sg-${var.environment}"
  vpc_id      = "${var.vpc_id}"
  description = "Security group that allows only the specified EC2 instance to access RDS"

  ingress {
    from_port       = "${var.db_port}"
    to_port         = "${var.db_port}"
    protocol        = "TCP"
    security_groups = ["${var.ec2_sg}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.application}-rds-sg-${var.environment}"
  }
}
