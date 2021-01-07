variable "aws_region" {
  description = "The AWS region to deploy into (default: eu-central-1)."
  default     = "eu-central-1"
}

variable "organization_name" {
  description = "The organization name provisioning the template (default: fujitsu-cee)"
  default     = "fujitsu-cee"
}

variable "char_delimiter" {
  description = "The delimiter to use for unique names (default: -)"
  default     = "-"
}

variable "repo_name" {
  description = "The name of the CodeCommit repository (e.g. new-repo)."
  default     = "toolchain"
}

variable "repo_default_branch" {
  description = "The name of the default repository branch (default: master)"
  default     = "master"
}

variable "force_artifact_destroy" {
  description = "Force the removal of the artifact S3 bucket on destroy (default: true)."
  default     = "true"
}

variable "environment" {
  description = "The environment being deployed (default: dev)"
  default     = "dev"
}

variable "build_timeout" {
  description = "The time to wait for a CodeBuild to complete before timing out in minutes (default: 5)"
  default     = "5"
}

variable "build_compute_type" {
  description = "The build instance type for CodeBuild (default: BUILD_GENERAL1_SMALL)"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "The build image for CodeBuild to use (default: aws/codebuild/amazonlinux2-x86_64-standard:3.0)"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "build_privileged_override" {
  description = "Set the build privileged override to 'true' if you are not using a CodeBuild supported Docker base image. This is only relevant to building Docker images"
  default     = "false"
}

variable "package_buildspec" {
  description = "The buildspec to be used for the Package stage (default: buildspec.yml)"
  default     = "buildspec.yml"
}