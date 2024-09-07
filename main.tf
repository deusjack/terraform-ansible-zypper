resource "ansible_playbook" "repos" {
  for_each                = var.repos
  name                    = var.hostname
  playbook                = "${path.module}/zypper_add_repo.yaml"
  replayable              = false
  ignore_playbook_failure = false
  extra_vars = {
    repo_name         = each.key
    repo_url          = each.value.url
    priority          = each.value.priority
    disable_gpg_check = each.value.disable_gpg_check
  }
  lifecycle {
    replace_triggered_by = [
      null_resource.zypper_add_repo,
      null_resource.variables_repos
    ]
  }
}

resource "ansible_playbook" "packages" {
  depends_on              = [ansible_playbook.repos]
  name                    = var.hostname
  playbook                = "${path.module}/zypper_install.yaml"
  replayable              = false
  ignore_playbook_failure = false
  extra_vars = {
    names = jsonencode(var.packages)
  }
  lifecycle {
    replace_triggered_by = [
      null_resource.zypper_install,
      null_resource.variables_packages
    ]
  }
}

resource "ansible_playbook" "packages_uninstall" {
  depends_on              = [ansible_playbook.packages]
  name                    = var.hostname
  playbook                = "${path.module}/zypper_uninstall.yaml"
  replayable              = false
  ignore_playbook_failure = false
  extra_vars = {
    names = jsonencode(var.packages_uninstall)
  }
  lifecycle {
    replace_triggered_by = [
      null_resource.zypper_uninstall,
      null_resource.variables_packages_uninstall
    ]
  }
}
