variable "ami" {
  description = "AWS AMI ID for your EC2 instance"
}

variable "instance_type" {
  description = "The EC2 instance type"
}

variable "key_name" {
  description = "Key pair used for your EC2 instance"
}

variable "public_subnet_id" {
  description = "The ID of the subnet you want to deploy your EC2 instance"
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with"
}

variable "ec2_name" {
  description = "Name tag of your EC2 instance"
}

variable "sg_name" {
  description = "Name tag of your SG"
}

variable "cidrs" {
  description = "SG cidr blocks"
}

variable "tcp_ports" {
  description = "TCP ports for SG"
}
