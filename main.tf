# default provider (configurable)
provider "aws" {
  region = var.aws_region
}

# Global resources provider (ACM, Hosted zone)
provider "aws" {
  alias  = "us_provider"
  region = local.aws_us_region
}

locals {
  tags = merge(var.tags, {
    "asd:environment" = var.environment
  })
  aws_us_region = "us-east-1"
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

  aws_us_region = local.aws_us_region
}

data "aws_route53_zone" "main_domain" {
  count = var.create_custom_domain ? 1 : 0

  name         = "${var.hosted_zone_domain}."
  private_zone = false
}

module "dns" {
  count = var.create_custom_domain ? 1 : 0

  source = "./modules/dns"

  hosted_zone_id     = data.aws_route53_zone.main_domain[0].zone_id
  custom_domain_name = var.custom_domain_name
  cloudflare_domain  = module.cloudfront.cloudflare_domain
  cloudflare_zone_id = module.cloudfront.cloudflare_zone_id

  providers = {
    aws = aws.us_provider
  }
}
