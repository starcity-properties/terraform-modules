resource "aws_instance" "ec2" {
  ami = "ami-0bdb828fd58c52235"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet_id}"
}