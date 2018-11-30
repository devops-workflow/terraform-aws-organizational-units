variable "aws_profile" {
  description = "AWS profile in local credentials file that has rights to master account"
}

variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ou_list" {
  description = "List of organizational unit to manage. These will be top level under root"
}
