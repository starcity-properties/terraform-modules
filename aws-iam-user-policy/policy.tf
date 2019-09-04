# policy
resource "aws_iam_user_policy" "policy" {
  name = var.name
  user = var.user
  policy = var.policy
}