variable "ami" {
  description = "AWS AMI ID for your EC2 instance"
}

variable "instance_type" {
  description = "The EC2 instance type"
}

variable "key_name" {
  description = "Key pair used for your EC2 instance"
}

variable "subnet_id" {
  description = "The ID of the subnet you want to deploy your EC2 instance"
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with"
}
