output "cloudflare_domain" {
  description = "Cloudflare domain to CNAME to"
  value       = aws_cloudfront_distribution.static_content_distribution.domain_name
}

output "cloudflare_zone_id" {
  description = "Cloudflare zone id"
  value       = aws_cloudfront_distribution.static_content_distribution.hosted_zone_id
}

output "oai_id" {
  description = "OAI ID"
  value       = aws_cloudfront_origin_access_identity.newOAI.id
}
