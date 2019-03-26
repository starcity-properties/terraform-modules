resource "aws_iam_group" "group" {
  name = "${var.aws_group_name}"
  path = "${var.aws_group_path}"
}