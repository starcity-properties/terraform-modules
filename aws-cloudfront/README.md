Module for creating a Cloudfront distribution.

## Usage

### Arguments
| Name | Description | Type | Default |
|------|-------------|:----:|:-------:|
| `environment` | AWS environment (e.g. staging/production)| string | - |
| `region` | The AWS region you want to deploy to | string | us-west-1 |
| `cloudfront_enabled` | If the CloudFront distribution should be enabled | string | true |
| `cloudfront_ipv6_enabled` | If IPv6 should be enabled | string | true
| `cloudfront_comment` | Any comments you want to include about the distribution | string | -
| `cloudfront_aliases` | Extra CNAMEs (alternate domain names), if any, for this distribution | list | []
| `ssl_support_method` | Specifies how you want CloudFront to serve HTTPS requests | string | sni-only
| `dynamic_custom_origins` | The CloudFront custom origin configuration information | list | []
| `dynamic_s3_origins` | The CloudFront custom origin configuration information | list | []
| `allowed_methods` | The default cache allowed methods | list | ["GET", "HEAD"]
| `cached_methods` | The default cache methods | list | ["GET", "HEAD"]
| `cookies` | CloudFront cookie forwarding | string | none
| `query_string` | CloudFront query string forwarding | string | true
| `headers` | CloudFront forwarded headers | list | []
| `target_origin_id` | The target origin ID | string | -
| `dynamic_ttl` | Map of TTLs (`default_ttl`, `min_ttl`, & `max_ttl`) | map | -
| `compress` | Enable gzip compression | string | false
| `viewer_protocol_policy` | The viewer protocol policy | string | redirect-to-https
| `acm_certificate_arn` | The CloudFront ACM certificate ARN | string | -
| `minimum_protocol_version` | The minimum protocol version | string | TLSv1.1_2016
| `cloudfront_default_certificate` | Use CloudFront default certificate | string | true
| `dynamic_ordered_cache_behaviors` | A list of ordered cache behaviors | list | -








