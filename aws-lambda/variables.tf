# global
variable "environment" {
  description = "the AWS environment"
}

variable "region" {
  description = "The AWS region"
  default = "us-west-1"
}

# lambda
variable "description" {
  description = "The description of the AWS Lambda function"
  default = null
}

variable "function_name" {
  description = "The name of the Lambda function"
}

variable "filename" {
  description = "The filename of the Lambda function"
}

variable "handler" {
  description = "The Lambda handler"
}

variable "runtime" {
  description = "The runtime engnine of the Lambda function"
}

variable "role" {
  description = "The role of the Lambda function"
}

variable "timeout" {
  description = "The timeout for a Lambda function in seconds"
  default = null
}

variable env_vars {
  description = "Map of environment variables for the Lambda function."
  type        = "map"
}