# Example Website Terraform Module without Custom Domain

Deploy your static website on AWS without the need for a custom domain using this Terraform module. It provisions essential resources such as an S3 bucket, CloudFront distribution, and IAM user for secure and efficient hosting.

## Overview

This module sets up a static website hosting environment optimized for production use. By creating a secure S3 bucket to host your content, setting up a CloudFront distribution for fast global access, and establishing IAM security for continuous deployment processes, the module offers a straightforward approach to deploying static websites on AWS.

### Architecture Diagram

![](../../assets/diagram.png)

## How to Use This Module

To deploy your static website without a custom domain, you can use the module in your Terraform configuration like so:

```hcl
module "website" {
  source = "../../"

  name                 = "example-website"
  environment          = "prod"
  create_custom_domain = false
  aws_region           = "us-east-2"
}

provider "aws" {
  region = "us-east-2"
}
```

### Inputs for Default Domain Setup

| Name                    | Description                                            | Type     | Default | Required |
|-------------------------|--------------------------------------------------------|----------|---------|:--------:|
| `name`                  | The project/site name                                  | `string` | n/a     | yes      |
| `environment`           | The environment (e.g., staging, prod)                  | `string` | n/a     | yes      |
| `create_custom_domain`  | A flag indicating whether to create a custom domain    | `bool`   | `false` | no       |
| `aws_region`            | AWS region where resources will be created             | `string` | n/a     | yes      |

### Outputs

| Name                      | Description                              | Sensitive |
|---------------------------|------------------------------------------|:---------:|
| `cloudflare_domain`       | The direct CloudFront domain             | No        |
| `bucket_name`             | The name of the S3 bucket                | No        |
| `access_key_id`           | Access key ID for the S3 user            | No        |
| `secret_access_key`       | Secret access key for the S3 user        | Yes       |
| `domain_certificate_arn`  | The ARN of the default domain certificate| No        |

To retrieve sensitive outputs like the `secret_access_key`, use the `terraform output` command with caution, for example: `terraform output secret_access_key`.

## License

This code is provided under the MIT License. Full licensing details are available in the included [LICENSE.md](LICENSE.md) file.