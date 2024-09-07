#################
# ansible files #
#################

resource "null_resource" "zypper_install" {
  triggers = {
    zypper_install = filemd5("${path.module}/zypper_install.yaml")
  }
}

resource "null_resource" "zypper_uninstall" {
  triggers = {
    zypper_uninstall = filemd5("${path.module}/zypper_uninstall.yaml")
  }
}

resource "null_resource" "zypper_add_repo" {
  triggers = {
    zypper_add_repo = filemd5("${path.module}/zypper_add_repo.yaml")
  }
}

#####################
# external triggers #
#####################

resource "null_resource" "external" {
  triggers = var.external_triggers
}

#############
# variables #
#############

resource "null_resource" "variables_packages" {
  triggers = {
    packages = join(", ", var.packages)
  }
}

resource "null_resource" "variables_packages_uninstall" {
  triggers = {
    packages_uninstall = join(", ", var.packages_uninstall)
  }
}

resource "null_resource" "variables_repos" {
  triggers = {
    repos = join(", ", [for k, v in var.repos : "${k}: ${v.url}, ${v.priority}, ${v.disable_gpg_check}"])
  }
}
