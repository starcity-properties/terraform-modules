# =============================================================
# ECS IAM roles
# =============================================================

data "aws_iam_policy_document" "ecs_task_execution" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ecs-tasks.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "ecs_execution" {
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions   = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

resource "aws_iam_role" "ecs_execution_role" {
  name               = "${var.application}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution.json
}

resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  policy = data.aws_iam_policy_document.ecs_execution.json
  role   = aws_iam_role.ecs_execution_role.id
}

