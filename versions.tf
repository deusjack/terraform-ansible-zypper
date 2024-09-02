terraform {
  required_version = ">= 1.8"
  required_providers {
    ansible = {
      source  = "ansible/ansible"
      version = ">= 1, < 2"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3, < 4"
    }
  }
}
