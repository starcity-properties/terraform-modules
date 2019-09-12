variable "environment" {
}

variable "region" {
}

variable "vpc_id" {
}

variable "application" {
  description = "Application name"
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "port" {
  description = "Port to run service"
}

variable "desired_count" {
  description = "Desired count"
  default     = 1
}

variable "container_port" {
  description = "Port in container"
}

variable "db_access_sg" {
  description = "Database access security group"
}

variable "cpu" {
  description = "ECS task CPU"
  default     = 1024
}

variable "memory" {
  description = "ECS task memory"
  default     = 2048
}

variable "acm_arn" {
  description = "ARN of the SSL certificate"
}

variable "log_bucket" {
  description = "Bucket for writing logs"
}

variable "alb_health_check" {
  description = "Health check configuration for ALB"
  type        = "map"
}