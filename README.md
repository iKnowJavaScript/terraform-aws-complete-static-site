
# Terraform AWS Complete Static Site Module

[![Terraform registry](https://img.shields.io/badge/Terraform_Registry-0.0.2-blue)](https://registry.terraform.io/modules/iKnowJavaScript/complete-static-site/aws/latest)
[![Terraform](https://img.shields.io/badge/Terraform-0.0.2-623CE4)](https://www.terraform.io)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

This Terraform module consist the configuration for hosting a static website on AWS. It creates and configures the necessary AWS resources including S3, Route 53 (DNS), IAM, CloudFront, and WAF.

## Description

This Terraform module sets up an S3 bucket for storing your static website content, a CloudFront distribution for content delivery, OAI for access the bucket through CloudFront(Secure access), a WAF WebACL for protecting your site, and a Route 53 record for DNS. It also creates an IAM user for managing continuous deployment to the s3 bucket.

This module provisions:

- AWS Route53 records
- AWS ACM certificates
- AWS CloudFront distributions
- IAM user
- S3 bucket

### Architecture Diagram
![image](assets/diagram.png)

## Usage

### Example with a custom domain (sub domain)
```hcl
module "frontend" {
  source  = "iKnowJavaScript/complete-static-site/aws"

  name                 = "example-website"
  environment          = "prod"
  create_custom_domain = true
  hosted_zone_domain   = "example.com"
  custom_domain_name   = "example-website.example.com"
  aws_region           = "us-east-1"
  tags                 = {}
}

provider "aws" {
  region = "us-east-1"
}
```

### Example with default CloudFlare domain
```hcl
module "frontend" {
  source  = "iKnowJavaScript/complete-static-site/aws"

  name                 = "example-website"
  environment          = "prod"
  create_custom_domain = false
  aws_region           = "us-east-1"
  tags                 = {}
}

provider "aws" {
  region = "us-east-1"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws_region | The AWS region to create resources in | `string` | n/a | no |
| hosted_zone_domain | (OPTIONAL) Hosted zone to add doamin and cloufront Cname to | `string` | n/a | no |
| custom_domain_name | (OPTIONAL) Custom domain name. should be a sub.domain to the main domain available on the hosted zone or ''(empty string) to use the domain on hosted zone. | `string` | n/a | no |
| create_custom_domain | Whether to create a custom domain | `bool` | `false` | no |
| name | The project name | `string` | n/a | yes |
| environment | The environment the resources is meant for. | `string` | n/a | yes |
| tags | Resources tags. | `map(string)` | n/a | no |


## Outputs

| Name | Description | Sensitive |
|------|-------------|:---------:|
| cloudflare_domain | Direct cloudflare domain | No |
| custom_domain | Custom domain name | No |
| bucket_name | S3 bucket name | No |
| access_key_id | The access key ID for the S3 user | No |
| secret_access_key | The secret access key for the S3 user | Yes |
| domain_certificate_arn | The ARN of the domain certificate | No |

*To view sensitive secret, try `terraform output secret_access_key`*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
