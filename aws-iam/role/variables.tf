variable "environment" {}

variable "name" {
  description = "The name of the role."
}

variable "type" {
  description = "(Required) The type of principal. For AWS ARNs this is \"AWS\". For AWS services (e.g. Lambda), this is \"Service\"."
}

variable "identifiers" {
  description = "(Required) List of identifiers for principals. When type is \"AWS\", these are IAM user or role ARNs. When type is \"Service\", these are AWS Service roles e.g. lambda.amazonaws.com."
}

variable "policies" {
  description = "(Optional, default []). List of policiy ARNs to attach to the role."
  type        = "list"
  default     = []
}

variable "policy_documents" {
  description = "(Optional, default []). List of policiy documents to attach to the role. Read more about policy documents at https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html."
  type        = "list"
  default     = []
}
