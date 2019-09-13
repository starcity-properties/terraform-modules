resource "aws_iam_group" "group" {
  name = var.name
  path = var.path
}

resource "aws_iam_group_policy_attachment" "policy" {
  count = length(var.policies)

  policy_arn = var.policies[count.index]
  group      = aws_iam_group.group.name
}

resource "aws_iam_group_policy" "group_policy" {
  count  = length(var.policy_documents)
  group  = aws_iam_group.group.name
  policy = var.policy_documents[count.index]
}