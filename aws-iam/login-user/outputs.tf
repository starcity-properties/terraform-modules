output "name" {
  value = aws_iam_user.user.name
}

output "password" {
  description = "The encrypted password, base64 encoded. ~> NOTE: The encrypted password may be decrypted using the command line, for example: `terraform output encrypted_secret | base64 --decode | keybase pgp decrypt`."
  value       = aws_iam_user_login_profile.login_profile.encrypted_password
}