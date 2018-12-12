provider "aws" {
  region = "${var.aws_region}"

  #shared_credentials_file = ""
  profile                     = "${var.aws_profile}"
  skip_credentials_validation = true
  skip_get_ec2_platforms      = true
  skip_region_validation      = true
}
