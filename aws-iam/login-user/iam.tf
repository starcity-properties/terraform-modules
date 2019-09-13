resource "aws_iam_user" "user" {
  name          = var.name
  force_destroy = var.force_destroy
}

resource "aws_iam_user_login_profile" "login_profile" {
  user                    = aws_iam_user.user.name
  pgp_key                 = var.pgp_key
  password_reset_required = var.password_reset_required
}

resource "aws_iam_user_group_membership" "team" {
  user   = aws_iam_user.user.name
  groups = var.groups
}

