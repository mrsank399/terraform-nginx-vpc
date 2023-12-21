variable "load_balancer_dns_name" {
  type = string
}

variable "cloudfront_methods" {
  type    = list(string)
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cloudfront_cache_methods" {
  type    = list(string)
  default = ["GET", "HEAD"]
}

variable "ssl_protocols" {
  type    = list(string)
  default = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}