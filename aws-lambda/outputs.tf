output "lambda_arn" {
  description = "The ARN of the lambda function"
  value = aws_lambda_function.lambda.arn
}