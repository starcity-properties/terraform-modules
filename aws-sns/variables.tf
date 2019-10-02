# global
variable "region" {
  description = "The AWS region"
  default     = "us-west-1"
}

variable "environment" {
  description = "The AWS snvironment"
}

# SNS
variable "name" {
  description = "The name of the SNS topic"
}