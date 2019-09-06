resource "aws_iam_group_policy_attachment" "policy" {
  group      = aws_iam_group.group.name
  policy_arn = var.aws_policy
}

resource "aws_iam_group_policy_attachment" "change_password" {
  group      = aws_iam_group.group.name
  policy_arn = var.aws_change_password_policy
}