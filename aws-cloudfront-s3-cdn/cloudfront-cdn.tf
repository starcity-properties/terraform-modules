# WIP

resource "aws_cloudfront_distribution" "s3_distribution" {
  dynamic "origin" {
    for_each = var.cloudfront_origin
    content {
      # TF-UPGRADE-TODO: The automatic upgrade tool can't predict
      # which keys might be set in maps assigned here, so it has
      # produced a comprehensive set here. Consider simplifying
      # this after confirming which keys can be set in practice.

      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      origin_path = lookup(origin.value, "origin_path", null)

      dynamic "custom_header" {
        for_each = lookup(origin.value, "custom_header", [])
        content {
          name  = custom_header.value.name
          value = custom_header.value.value
        }
      }

      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config", [])
        content {
          http_port                = custom_origin_config.value.http_port
          https_port               = custom_origin_config.value.https_port
          origin_keepalive_timeout = lookup(custom_origin_config.value, "origin_keepalive_timeout", null)
          origin_protocol_policy   = custom_origin_config.value.origin_protocol_policy
          origin_read_timeout      = lookup(custom_origin_config.value, "origin_read_timeout", null)
          origin_ssl_protocols     = custom_origin_config.value.origin_ssl_protocols
        }
      }

      dynamic "s3_origin_config" {
        for_each = lookup(origin.value, "s3_origin_config", [])
        content {
          origin_access_identity = s3_origin_config.value.origin_access_identity
        }
      }
    }
  }
  enabled         = var.cloudfront_enabled
  is_ipv6_enabled = var.cloudfront_ipv6_enabled
  comment         = var.cloudfront_comment
  aliases         = [var.cloudfront_aliases]
}

