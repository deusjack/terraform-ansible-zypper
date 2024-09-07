variable "external_triggers" {
  type        = map(string)
  description = "Triggers for rerunning the directory playbook except variables"
  default     = {}
}

# Doesn't need a trigger. On change the playbooks is automatically replaced.
variable "hostname" {
  type        = string
  description = "The hostname of linux machine the directory will be created on"
}

variable "packages" {
  type        = list(string)
  description = "List of packages to be installed"
  default     = []
}

variable "packages_uninstall" {
  type        = list(string)
  description = "List of packages to be uninstalled"
  default     = []
}

variable "repos" {
  type = map(object({
    url               = string
    priority          = optional(number, 90)
    disable_gpg_check = optional(bool, false)
  }))
  description = "Map of repos to add"
  default     = {}
}
