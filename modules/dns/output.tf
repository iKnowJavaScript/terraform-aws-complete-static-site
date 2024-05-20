output "certificate_arn" {
  description = "Certificate ARN"
  value       = aws_acm_certificate.domain_cert.arn
}
