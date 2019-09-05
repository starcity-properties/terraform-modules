output "encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value = element(
    concat(
      aws_iam_user_login_profile.login_profile.*.encrypted_password,
      [""],
    ),
    0,
  )
}

output "iam_user_name" {
  description = "The name of the IAM user"
  value = aws_iam_user.user.name
}

output "iam_user_arn" {
  description = "The ARN of the IAM user"
  value = aws_iam_user.user.arn
}