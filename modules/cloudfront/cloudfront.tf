resource "aws_cloudfront_origin_access_identity" "newOAI" {
  comment = "OAI for ${var.name} S3 bucket"
}

resource "aws_cloudfront_distribution" "static_content_distribution" {
  origin {
    domain_name = var.bucket_domain_name
    origin_id   = "S3Origin"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.newOAI.cloudfront_access_identity_path
    }
  }


  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  comment             = "${var.name} - frontend deployment"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
  }

  custom_error_response {
    error_code            = 404
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 403
    response_page_path    = "/index.html"
    response_code         = 200
    error_caching_min_ttl = 300
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  aliases = var.create_custom_domain ? [var.custom_domain_name] : []


  dynamic "viewer_certificate" {
    for_each = var.create_custom_domain ? [1] : []

    content {
      acm_certificate_arn      = var.domain_certificate_arn
      ssl_support_method       = "sni-only"
      minimum_protocol_version = "TLSv1.2_2018"
    }
  }


  dynamic "viewer_certificate" {
    for_each = var.create_custom_domain ? [] : [1]

    content {
      cloudfront_default_certificate = true
    }
  }

  web_acl_id = aws_wafv2_web_acl.web_acl.arn

  tags = var.tags
}

