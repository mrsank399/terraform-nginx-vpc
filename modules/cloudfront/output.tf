output "cloudfront_dns_name" {
  value = aws_cloudfront_distribution.cloudfront_lb_distribution.domain_name
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.cloudfront_lb_distribution.id
}

output "cloudfront_zone_id" {
  value = aws_cloudfront_distribution.cloudfront_lb_distribution.hosted_zone_id
}