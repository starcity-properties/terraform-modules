variable "name" {
  description = "(Required) The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both \"ADMINS\" and \"admins\"."
}

variable "path" {
  description = "(Optional, default \"/\") Path in which to create the group."
  default     = "/"
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