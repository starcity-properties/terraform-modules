resource aws_instance ec2 {
  ami                    = "${var.ami}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = ""
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ""

  lifecycle {
    create_before_destroy = true
  }
}
