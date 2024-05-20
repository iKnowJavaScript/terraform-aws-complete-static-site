variable "create_custom_domain" {
  type        = bool
  description = "(OPTIONAL) Whether to use a custom domain or not"
  default     = false
}

variable "custom_domain_name" {
  type        = string
  description = "Custom domain name that wil be added to the hosted zone"
}

variable "bucket_domain_name" {
  type        = string
  description = "Bucket domain name that wil be added to Cloudfront"
}

variable "name" {
  description = "Name of the application"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags that will be added to created resources. By default resources will be tagged with name and environment."
  type        = map(string)
  default     = {}
}

variable "domain_certificate_arn" {
  type        = string
  description = "Domain xertificate to cname cloudflare into"
  default     = null
  nullable    = true
}


variable "aws_us_region" {
  type        = string
  description = "US AWS region."
  default     = "us-east-1"
}
