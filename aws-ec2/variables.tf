variable "environment" {
  description = "AWS environment"
}

variable "application" {
  description = "The name of your application"
}

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
  type        = list(string)
  description = "The ID of the subnet you want to deploy your EC2 instance"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "ssh_cidr" {
  type        = list(string)
  description = "CIDR block for bastion access"
}

variable "volume_type" {
  description = "The volume type for EC2"
}

variable "volume_size" {
  description = "The volume size for EC2"
}

variable "ingress_port" {
  description = "The ingress port for the SG"
}

variable "iam_instance_profile" {
  description = "The instance profile used for your EC2 instance"
}

