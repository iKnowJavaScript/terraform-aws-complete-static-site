data "aws_route53_zone" "main_domain" {
  name         = "${var.hosted_zone_domain}."
  private_zone = false
}

resource "aws_route53_record" "domain_record" {
  zone_id = data.aws_route53_zone.main_domain.zone_id
  name    = var.custom_domain_name
  type    = "A"
  # ttl     = "300"
  # records = [aws_cloudfront_distribution.static_content_distribution.domain_name]

  alias {
    name                   = var.cloudflare_domain 
    zone_id                = var.cloudflare_zone_id
    evaluate_target_health = false
  }
}

resource "aws_acm_certificate" "domain_cert" {
  domain_name       = var.custom_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_acm_certificate_validation" "domain_cert_validation" {
  certificate_arn         = aws_acm_certificate.domain_cert.arn
  validation_record_fqdns = [for record in aws_acm_certificate.domain_cert.domain_validation_options : "${record.resource_record_name}"]

  depends_on = [
    aws_route53_record.domain_dns_validation
  ]
}


resource "aws_route53_record" "domain_dns_validation" {
  for_each = {
    for dvo in aws_acm_certificate.domain_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  zone_id         = data.aws_route53_zone.main_domain.zone_id
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
  ttl             = 60
}

