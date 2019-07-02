variable "environment" {
  description = "AWS environment"
}

variable "application" {
  description = "The name of the application"
}

variable "region" {
  description = "AWS region"
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
}

variable "username" {
  description = "Username for the database"
}

variable "password" {
  description = "Password for the database"
}



