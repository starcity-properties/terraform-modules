resource "aws_iam_user" "user" {
  name          = "${var.name}-sa"
  force_destroy = var.force_destroy
}

resource "aws_iam_access_key" "access-key" {
  user    = aws_iam_user.user.name
  pgp_key = var.pgp_key
}

resource "aws_iam_user_policy_attachment" "policy" {
  count = length(var.policies)

  policy_arn = var.policies[count.index]
  user       = aws_iam_user.user.name
}

resource "aws_iam_user_policy" "user_policy" {
  count = length(var.policy_documents)

  policy = var.policy_documents[count.index]
  user   = aws_iam_user.user.name
}