variable "environment" {
  description = "AWS environment"
}

variable "application" {
  description = "The name of the application"
}

variable "allocated_storage" {
  description = "Amount of storage space for RDS"
}

variable "storage_type" {
  description = "RDS storage type"
}

variable "engine" {
  description = "Database engine"
}

variable "engine_version" {
  description = "Database engine version"
}

variable "instance_class" {
  description = "RDS instance class e.g. db.t2"
}

variable "name" {
  description = "Name of the database"
  default     = "postgres"
}

variable "username" {
  description = "Username for the database"
}

variable "password" {
  description = "Password for the database"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

variable "private_subnet_id" {
  type        = "list"
  description = "ID of the private subnet"
}

variable "ec2_sg" {
  description = "ID for the EC2 security group"
}

variable "db_port" {
  description = "DB port used for ingress and outgress"
}
