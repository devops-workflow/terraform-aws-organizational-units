module "example" {
  source      = "../../"
  aws_profile = "${var.aws_profile}"
  ou_list     = "${var.ou_list}"
}
