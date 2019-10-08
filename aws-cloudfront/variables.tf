# global
variable "environment" {
  description = "the AWS environment"
}

variable "region" {
  description = "The AWS region"
  default     = "us-west-1"
}

# cloudfront
variable "cloudfront_enabled" {
  description = "Is distribution enabled"
  default     = "true"
}

variable "cloudfront_ipv6_enabled" {
  description = "Is IPv6 enabled"
  default     = "true"
}

variable "cloudfront_comment" {
  description = "Cloudfront comment"
  default     = ""
}
variable "cloudfront_aliases" {
  description = "Extra CNAMEs"
  default     = []
}

variable "ssl_support_method" {
  description = "SSL support method"
  default     = "sni-only"
}

variable "dynamic_custom_origins" {
  description = "cloudfront custom origins"
  type        = "list"
  default     = []
}

variable "dynamic_s3_origins" {
  description = "cloudfront s3 origins"
  type        = "list"
  default     = []
}

variable "allowed_methods" {
  description = "The default cache allowed methods"
  type        = "list"
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  description = "The default cache cached methods"
  type        = "list"
  default     = ["GET", "HEAD"]
}

variable "cookies" {
  description = "CloudFront cookie forwarding"
  default     = "none"
}

variable "query_string" {
  description = "CloudFront query string forwarding"
  default     = true
}

variable "headers" {
  description = "The forwarded headers"
  default     = []
}

variable "target_origin_id" {
  description = "The target origin ID"
}

variable "dynamic_ttl" {
  description = "Map of TTLs"
  type        = "map"
}

variable "compress" {
  description = "gzip compression"
  default     = false
}

variable "viewer_protocol_policy" {
  description = "The viewer protocol policy"
  default     = "redirect-to-https"
}

variable "acm_certificate_arn" {
  description = "CloudFront ACM"
  default     = ""
}

variable "minimum_protocol_version" {
  description = "The minimum protocol version"
  default     = "TLSv1.1_2016"
}

variable "cloudfront_default_certificate" {
  description = "Use CloudFront default certificate"
  default     = true
}

variable "dynamic_ordered_cache_behaviors" {
  description = "A list of ordered cache behaviors"
  type        = "list"
}