# WIP

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    origin = "${var.cloudfront_origin}"
  }

  enabled         = "${var.cloudfront_enabled}"
  is_ipv6_enabled = "${var.cloudfront_ipv6_enabled}"
  comment         = "${var.cloudfront_comment}"
  aliases         = ["${var.cloudfront_aliases}"]
}
