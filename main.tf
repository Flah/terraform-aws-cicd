provider "aws" {
  region = "eu-central-1"
}

module "unique_label" {
  source     = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.22.1"
  namespace  = var.organization_name
  name       = var.repo_name
  stage      = var.environment
  delimiter  = var.char_delimiter
  attributes = []
  tags       = {}
}