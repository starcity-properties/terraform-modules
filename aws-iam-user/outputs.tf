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

