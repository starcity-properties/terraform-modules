variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets"
  default     = []
}

variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets"
  default     = []
}

variable "availability_zones" {
  type        = list(string)
  description = "A list of availability zones"
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

