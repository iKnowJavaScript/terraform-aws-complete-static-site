
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

## Cost Estimate

This cost estimate is based on **on-demand** pricing. AWS offers free tiers for some of these resources, which may reduce or eliminate costs for small-scale or new users.

Assuming 1,000 unique IPs traffic daily with the assumption of 1MB as page size, we'll have 30,000 Requests monthly and 30GB data transfer. Here's how the estimated breakdown will look like:

### S3
- **Storage**: $0.023/GB (Standard Storage) (Assuming our app is 100MB) = $0.0023 (Pretty low)
- **Request**: GET $0.0004 per 1,000 requests. 30,000 will be $0.012
- **Data Transfer**: Too low - CloudFront caching

### CloudFront
- **Data Transfer**: $0.085 per GB for the first 10TB = $0.085 * 30 = $2.55
- **Request**: $0.0075 per 10,000 HTTP/HTTPS requests. 30,000 will be $0.0225

### WAF
- **WebACL**: $5 per WebACL
- **Rule**: $1 per rule per WebACL. Assuming 10 rules, the cost will be $10
- **Requests**: $0.60 per 1 million requests. 30,000 requests will be $0.018

The total cost will be approximately **$2.586** for S3 and CloudFront, and $15.018 for WAF, making the grand total approximately $17.604.

Please note that these are just estimates. The actual cost may vary depending on the usage, data transfer, and number of requests. Also, this doesn't include potential costs for Route53, ACM, and other AWS services that might be used.

This changes drastically for 100M visits daily or weekly but latency will still be guaranteed.

This estimation serves as a rough guide. Actual costs may vary based on several factors, including the geographic distribution of requests, the size of the objects being requested, caching efficiency, and any applicable discounts or reserved pricing.

It’s important to employ strategies to minimize costs, such as optimizing content delivery, using budget alarms, employing efficient caching, and regularly reviewing usage patterns.

AWS offers a [pricing calculator](https://calculator.aws/#/) to provide more precise and tailored cost estimations, considering specific details and configurations of your static site deployment.


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
