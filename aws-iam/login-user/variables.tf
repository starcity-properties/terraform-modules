variable "name" {
  description = "(Required) The user's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both \"TESTUSER\" and \"testuser\"."
}

variable "pgp_key" {
  description = "(Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument."
}

variable "force_destroy" {
  description = "(Optional, default true) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  default     = true
}

variable "password_reset_required" {
  description = "(Optional, default true) Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument."
  default     = true
}

variable "groups" {
  description = "(Required) A list of IAM Groups to add the user to."
  type        = "list"
  default     = []
}