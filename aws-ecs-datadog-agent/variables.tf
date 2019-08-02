variable "dd_api_key" {
  description = "The API key for the Datadog account"
}

variable "ecs_task_role" {
  description = "The IAM role for ECS tasks"
}

variable "ecs_cluster_id" {
  description = "The ECS cluster ID"
}

variable "private_subnet_id" {
  description = "The private subnet ID associated with your ECS cluster"
  type        = "list"
}
