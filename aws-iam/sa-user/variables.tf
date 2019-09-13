variable "name" {
  description = "(Required) The user's name which will have \"-sa\" added at the end. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both \"TESTUSER\" and \"testuser\"."
}

variable "pgp_key" {
  description = "(Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument."
}

variable "force_destroy" {
  description = "(Optional, default true) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  default     = true
}

variable "policies" {
  description = "(Optional, default []). List of policiy ARNs to attach to the group."
  type        = "list"
  default     = []
}

variable "policy_documents" {
  description = "(Optional, default []). List of policiy documents to attach to the group. Read more about policy documents at https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html."
  type        = "list"
  default     = []
}
