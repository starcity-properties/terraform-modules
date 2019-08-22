variable "aws_name" {
}

variable "aws_pgp_key" {
}

variable "aws_groups" {
  type    = list(string)
  default = []
}

variable "aws_force_destroy" {
  default = "true"
}

variable "aws_password_reset_required" {
  default = "false"
}

variable "aws_user_enabled" {
  default = "true"
}

variable "aws_login_profile_enabled" {
  default = "true"
}

