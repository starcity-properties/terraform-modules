resource "aws_iam_group_policy_attachment" "policy" {
  group      = "${aws_iam_group.group.name}"
  policy_arn = "${var.aws_policy}"
}