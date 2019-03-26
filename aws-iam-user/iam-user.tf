resource "aws_iam_user" "user" {
  name                 = "${var.aws_name}"
  force_destroy        = "${var.aws_force_destroy}"
}

resource "aws_iam_user_login_profile" "login_profile" {
  user                    = "${aws_iam_user.user.name}"
  pgp_key                 = "${var.aws_pgp_key}"
  password_reset_required = "${var.aws_password_reset_required}"
}

resource "aws_iam_user_group_membership" "team" {
  user = "${aws_iam_user.user.name}"
  groups = ["${var.aws_groups}"]
}
s