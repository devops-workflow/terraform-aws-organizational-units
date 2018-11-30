/*
data "external" "organizational_units" {
  program = ["bash", "${path.module}/scripts/ou.sh"]

  query = {
    aws_profile = "${var.aws_profile}"
    ou_list     = "${var.ou_list}"
  }
}
/**/

resource "null_resource" "organizational_units" {
  triggers = {
    aws_profile = "${var.aws_profile}"
    ou_list     = "${var.ou_list}"
  }

  provisioner "local-exec" {
    command = "echo '${jsonencode(map("aws_profile", var.aws_profile, "ou_list", var.ou_list))}' | bash -c ${path.module}/scripts/ou.sh"
  }
}

data "external" "organizational_units" {
  program = ["bash", "${path.module}/scripts/get_ous.sh"]

  query = {
    aws_profile = "${var.aws_profile}"
  }
}
