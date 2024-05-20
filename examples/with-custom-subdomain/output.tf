output "cloudflare_domain" {
  description = "Direct cloudflare domain"
  value       = module.website.cloudflare_domain
}

output "custom_domain" {
  description = "Custom domain name"
  value       = module.website.custom_domain
}

output "bucket_name" {
  description = "S3 bucket name"
  value       = module.website.bucket_name
}

output "access_key_id" {
  value       = module.website.access_key_id
  description = "The access key ID for the S3 user"
}

output "secret_access_key" {
  value       = module.website.secret_access_key
  description = "The secret access key for the S3 user"
  sensitive   = true
}

# to view sensitive secret, try
# terraform output secret_access_key
