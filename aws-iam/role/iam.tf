data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.type
      identifiers = var.identifiers
    }
  }
}

resource "aws_iam_role" "role" {
  name = var.name

  assume_role_policy = data.aws_iam_policy_document.assume-role-policy.json

  tags = {
    Name        = var.name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "policy" {
  count = length(var.policies)

  policy_arn = var.policies[count.index]
  role       = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "role_policy" {
  count = length(var.policy_documents)

  role   = aws_iam_role.role.id
  policy = var.policy_documents[count.index]
}
