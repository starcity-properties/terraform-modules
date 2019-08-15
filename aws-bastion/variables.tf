variable "subnet_id" {
}

variable "ami" {
}

variable "instance_type" {
}

variable "environment" {
}

variable "vpc_id" {
}

variable "key_name" {
}

variable "bastion_cidr_blocks" {
  description = "List of IPs allowed to SSH into Bastion Host"
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "LIst of security groups to add to the bastion host"
  type        = list(string)
}

