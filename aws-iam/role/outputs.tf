output "iam_role_name" {
  value       = aws_iam_role.role.name
  description = "The role name."
}

output "iam_role_arn" {
  value       = aws_iam_role.role.arn
  description = "The role ARN."
}