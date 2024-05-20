variable "name" {
  description = "Name of the application"
  type        = string
  default     = null
}

variable "environment" {
  description = "(OPTIONAL) Name of the environment"
  type        = string
  default     = ""
  nullable    = true
}
variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "create_custom_domain" {
  type        = bool
  description = "(OPTIONAL) Whether to use a custom domain or not."
  default     = false
}

variable "hosted_zone_domain" {
  type        = string
  description = "(OPTIONAL) Hosted zone to add doamin and cloufront Cname to"
  nullable    = true
  default     = ""
}

variable "custom_domain_name" {
  type        = string
  description = "(OPTIONAL) Custom domain name. should be a sub.domain to the main domain available on the hosted zone or ''(empty string) to use the domain on hosted zone."
  nullable    = true
  default     = ""
}

variable "tags" {
  description = "Map of tags that will be added to created resources. By default resources will be tagged with name and environment."
  type        = map(string)
  default     = {}
}
