########################################################################
#   Module: Cloudfront for Load Balancer
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
## cloudfront load balancer
####################################

resource "aws_cloudfront_distribution" "cloudfront_lb_distribution" {
  origin {
    domain_name = var.load_balancer_dns_name
    origin_id   = var.load_balancer_dns_name

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront for Load Balancer"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = var.cloudfront_methods
    cached_methods   = var.cloudfront_cache_methods
    target_origin_id = var.load_balancer_dns_name

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
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}