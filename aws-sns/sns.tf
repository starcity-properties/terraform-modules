resource "aws_sns_topic" "sns" {
  name         = "${var.name}-${var.environment}"
  display_name = var.name

  tags = {
    Environment = var.environment
    Name        = var.name
    Region      = var.region
  }
}