variable "aws_group_name" {}
variable "aws_group_path" {}
variable "aws_policy" {}

variable "aws_change_password_policy" {
  default = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}