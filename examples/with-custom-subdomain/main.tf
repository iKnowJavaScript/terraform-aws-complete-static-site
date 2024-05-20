module "website" {
  source = "../../"

  name                 = "example-website"
  environment          = "prod"
  hosted_zone_domain   = "example.com"
  custom_domain_name   = "example-website.example.com"
  create_custom_domain = true
  aws_region           = "us-east-2"
}
