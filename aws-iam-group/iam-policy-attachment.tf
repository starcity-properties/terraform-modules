resource "aws_iam_group_policy_attachment" "policy" {
  group      = "${var.aws_group_name}"
  policy_arn = "${var.aws_policy}"
}