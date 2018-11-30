module "example" {
  source      = "../../"
  aws_profile = "${var.aws_profile}"
  aws_region  = "${var.aws_region}"
  ou_list     = "${var.ou_list}"
}
