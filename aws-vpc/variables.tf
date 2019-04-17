variable "public_subnets" {
  type        = "list"
  description = "A list of public subnets"
  default     = []
}

variable "private_subnets" {
  type        = "list"
  description = "A list of private subnets"
  default     = []
}

variable "vpc_cidr_block" {
  description = "the cidr block used for the VPC"
  default     = ""
}

variable "environment" {
  description = "Tags for AWS rescources"
  default     = ""
}
