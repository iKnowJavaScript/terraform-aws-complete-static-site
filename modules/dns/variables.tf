variable "hosted_zone_domain" {
  type        = string
  description = "Hosted zone to add doamin and cloufront Cname to"
}

variable "custom_domain_name" {
  type        = string
  description = "Custom domain name that wil be added to the hosted zone"
}

variable "cloudflare_domain" {
  type        = string
  description = "Cloudflare domain to CNAME to"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "Cloudflare zone id"
}
