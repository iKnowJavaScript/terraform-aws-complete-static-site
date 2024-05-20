output "cloudflare_domain" {
  description = "Direct cloudflare domain"
  value       = module.cloudfront.cloudflare_domain
}

output "custom_domain" {
  description = "Custom domain name"
  value       = var.custom_domain_name
}

output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.static_bucket.bucket
}

output "access_key_id" {
  value       = aws_iam_access_key.s3_user_key.id
  description = "The access key ID for the S3 user"
}

output "secret_access_key" {
  value       = aws_iam_access_key.s3_user_key.secret
  description = "The secret access key for the S3 user"
  sensitive   = true
}

# to view sensitive secret, try
# terraform output secret_access_key
