resource "aws_cloudfront_distribution" "cloudfront" {
  enabled         = var.cloudfront_enabled
  is_ipv6_enabled = var.cloudfront_ipv6_enabled
  comment         = var.cloudfront_comment
  aliases         = var.cloudfront_aliases

  dynamic "origin" {
    for_each = var.dynamic_custom_origins

    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      origin_path = lookup(origin.value, "origin_path", null)
      custom_origin_config {
        http_port                = origin.value.http_port
        https_port               = origin.value.https_port
        origin_keepalive_timeout = lookup(origin.value, "origin_keepalive_timeout", "5")
        origin_protocol_policy   = origin.value.origin_protocol_policy
        origin_read_timeout      = lookup(origin.value, "origin_read_timeout", "30")
        origin_ssl_protocols     = lookup(origin.value, "origin_ssl_protocols", ["TLSv1", "TLSv1.1", "TLSv1.2"])
      }
    }
  }

  dynamic "origin" {
    for_each = var.dynamic_s3_origins

    content {
      domain_name = origin.value.domain_name
      origin_id   = origin.value.origin_id
      origin_path = lookup(origin.value, "origin_path", null)
      s3_origin_config {
        origin_access_identity = origin.value.identity
      }
    }
  }

  default_cache_behavior {
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    target_origin_id       = var.target_origin_id
    viewer_protocol_policy = var.viewer_protocol_policy
    min_ttl                = lookup(var.dynamic_ttl, "min_ttl", null)
    default_ttl            = lookup(var.dynamic_ttl, "default_ttl", null)
    max_ttl                = lookup(var.dynamic_ttl, "max_ttl", null)
    compress               = var.compress
    forwarded_values {
      query_string = var.query_string
      headers      = var.headers
      cookies {
        forward = var.cookies
      }
    }
  }

  dynamic "ordered_cache_behavior" {
    for_each = var.dynamic_ordered_cache_behaviors

    content {
      path_pattern           = lookup(ordered_cache_behavior.value, "path_pattern")
      allowed_methods        = lookup(ordered_cache_behavior.value, "allowed_methods", ["GET", "HEAD"])
      cached_methods         = lookup(ordered_cache_behavior.value, "cached_methods", ["GET", "HEAD"])
      target_origin_id       = lookup(ordered_cache_behavior.value, "target_origin_id")
      viewer_protocol_policy = lookup(ordered_cache_behavior.value, "viewer_protocol_policy", "redirect-to-https")
      min_ttl                = lookup(ordered_cache_behavior.value, "min_ttl", null)
      default_ttl            = lookup(ordered_cache_behavior.value, "default_ttl", null)
      max_ttl                = lookup(ordered_cache_behavior.value, "max_ttl", null)
      compress               = lookup(ordered_cache_behavior.value, "compress", false)
      forwarded_values {
        query_string = lookup(ordered_cache_behavior.value, "query_string", false)
        headers      = lookup(ordered_cache_behavior.value, "headers", [])
        cookies {
          forward = lookup(ordered_cache_behavior.value, "cookies", "none")
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = var.cloudfront_default_certificate
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.ssl_support_method
    minimum_protocol_version       = var.minimum_protocol_version
  }

  tags = {
    Environment = var.environment
    Region      = var.region
  }
}