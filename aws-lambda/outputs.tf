output "lambda" {
  description = "The created Lambda function."
  value       = aws_lambda_function.lambda
}

# ##############################################
# Deprecated
# ##############################################

output "lambda_arn" {
  description = "The ARN of the lambda function"
  value       = aws_lambda_function.lambda.arn
}
