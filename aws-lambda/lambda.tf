resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  role             = var.role
  handler          = var.handler
  runtime          = var.runtime
  filename         = var.filename
  timeout          = var.timeout
  source_code_hash = filebase64sha256(var.filename)
  description      = var.description

  environment {
    variables = var.env_vars
  }

  tags = {
    Environment = var.environment
    Name        = var.function_name
    Region      = var.region
  }
}

