module "website" {
  source = "../../"

  name                 = "example-website"
  environment          = "prod"
  create_custom_domain = false
  aws_region           = "us-east-2"
}
