# AWS Static Website Hosting Project

This project provides a Terraform configuration for hosting a static website on AWS. It creates and configures the necessary AWS resources including S3, Route 53 (DNS), IAM, CloudFront, and WAF.

## Description

This project sets up an S3 bucket for storing your static website content, a CloudFront distribution for content delivery, a WAF WebACL for protecting your site, and a Route 53 record for DNS. It also creates an IAM user for managing continuous deployment to the s3 bucket.

## How to Use

1. **Clone the Repository**: Clone this repository to your local machine.

2. **Install Terraform**: If you haven't already, [install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli).

3. **Configure AWS Credentials**: Ensure your AWS credentials are correctly configured. You can set them in your environment variables or in your AWS credentials file.

4. **Update Credential**: Navigate to the project directory, update the `input.auto.tfvars` file to suite your project need and update `terraform.tf` backend object as deem fit or remove if you don't intent to save your states remotely.

5. **Initialize Terraform**: Navigate to the project directory and run `terraform init` to initialize your Terraform workspace.

6. **Apply the Configuration**: Run `terraform apply` to create the AWS resources. You'll be prompted to confirm that you want to create the resources.

7. **Upload Your Website**: Once the resources are created, you can upload your static website content to the S3 bucket. The bucket name will be output by the `terraform apply` command.

8. **Access Your Website**: After your content is uploaded, you can access your website via the CloudFront distribution URL, which will also be output by the `terraform apply` command.


## License

This project is licensed under the MIT License. See the [LICENSE.md](LICENSE.md) file for details.