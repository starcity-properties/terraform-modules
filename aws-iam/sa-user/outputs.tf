output "name" {
  value = aws_iam_user.user.name
}

output "arn" {
  value = aws_iam_user.user.arn
}

output "access_secret" {
  description = "The encrypted secret, base64 encoded. ~> NOTE: The encrypted secret may be decrypted using the command line, for example: terraform output encrypted_secret | base64 --decode | keybase pgp decrypt."
  value       = aws_iam_access_key.access-key.encrypted_secret
}

output "access_id" {
  description = "The access key ID."
  value       = aws_iam_access_key.access-key.id
}