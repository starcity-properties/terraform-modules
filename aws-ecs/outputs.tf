output "sg_id" {
  description = "ID of the created security group"
  value       = aws_security_group.alb-sg.id
}

output "cloudwatch_event_rule_running_ecs_name" {
  value = aws_cloudwatch_event_rule.running-deploy.name
}

output "cloudwatch_event_rule_failed_ecs_name" {
  value = aws_cloudwatch_event_rule.failed-deploy.name
}