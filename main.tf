# default provider (configurable)
provider "aws" {
  region = var.aws_region
}

# Global resources provider (ACM, Hosted zone)
provider "aws" {
  alias  = "us_provider"
  region = "us-east-1"
}

locals {
  tags = merge(var.tags, {
    "asd:environment" = var.environment
  })
}

resource "aws_s3_bucket" "static_bucket" {
  bucket = "${var.name}-${var.environment}"
}

module "cloudfront" {
  source = "./modules/cloudfront"

  create_custom_domain   = var.create_custom_domain
  name                   = var.name
  tags                   = local.tags
  domain_certificate_arn = var.create_custom_domain ? module.dns[0].certificate_arn : null
  custom_domain_name     = var.custom_domain_name
  bucket_domain_name     = aws_s3_bucket.static_bucket.bucket_regional_domain_name
}


module "dns" {
  count = var.create_custom_domain ? 1 : 0

  source = "./modules/dns"

  hosted_zone_domain = var.hosted_zone_domain
  custom_domain_name = var.custom_domain_name
  cloudflare_domain  = module.cloudfront.cloudflare_domain
  cloudflare_zone_id = module.cloudfront.cloudflare_zone_id
}
