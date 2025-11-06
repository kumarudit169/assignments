resource "aws_cloudfront_distribution" "multi_origin" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "BlueStacks DevOps Challenge - Multi-Origin Distribution"
  default_root_object = ""  # IMPORTANT: Leave empty to allow path pattern matching on root
  price_class         = "PriceClass_100"  # Cost optimization
  origin {
    domain_name = aws_s3_bucket_website_configuration.origin_primary.website_endpoint
    origin_id   = "primary-s3-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"  # S3 website endpoints only support HTTP
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "X-Origin-Verify"
      value = "primary-origin"
    }
  }

  origin {
    domain_name = aws_s3_bucket_website_configuration.origin_secondary.website_endpoint
    origin_id   = "secondary-s3-origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "X-Origin-Verify"
      value = "secondary-origin"
    }
  }

  default_cache_behavior {
    target_origin_id       = "primary-s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    # 48 HOUR CACHE as per requirement
    min_ttl     = 0
    default_ttl = 172800  # 48 hours = 48 * 60 * 60 = 172800 seconds
    max_ttl     = 172800

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  ordered_cache_behavior {
    path_pattern           = "/devops-folder/*"
    target_origin_id       = "secondary-s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true

    # Default cache settings for secondary origin
    min_ttl     = 0
    default_ttl = 172800    # 48 hours
    max_ttl     = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name       = "BlueStacks Multi-Origin Distribution"
    Assignment = "DevOps Challenge"
  }
}
