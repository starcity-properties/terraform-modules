# ##############################################
# ECR repo
# ##############################################

resource "aws_ecr_repository" "ecr_repo" {
  name = var.name

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

