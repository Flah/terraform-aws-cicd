data "template_file" "codepipeline_assume_role_policy_template" {
  template = file("${path.module}/iam-policies/codebuild-assume-role.tpl")
}

resource "aws_iam_role" "codebuild_assume_role" {
  name               = "${module.unique_label.name}-codebuild-role"
  assume_role_policy = data.template_file.codepipeline_assume_role_policy_template.rendered
}

data "template_file" "codebuild_policy_template" {
  template = file("${path.module}/iam-policies/codebuild.tpl")
  vars = {
    artifact_bucket           = aws_s3_bucket.build_artifact_bucket.arn
    backend_bucket            = var.tf_state_bucket_arn
    codebuild_terraform_plan  = aws_codebuild_project.plan.id
    codebuild_terraform_apply = aws_codebuild_project.apply.id
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "${module.unique_label.name}-codebuild-policy"
  role = aws_iam_role.codebuild_assume_role.id

  policy = data.template_file.codebuild_policy_template.rendered
}

resource "aws_codebuild_project" "plan" {
  name           = "${var.repo_name}"
  description    = "The CodeBuild project for ${var.repo_name}"
  service_role   = aws_iam_role.codebuild_assume_role.arn
  build_timeout  = var.build_timeout

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = var.build_compute_type
    image           = var.build_image
    type            = "LINUX_CONTAINER"
    privileged_mode = var.build_privileged_override
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec_plan
  }
}

resource "aws_codebuild_project" "apply" {
  name           = "${var.repo_name}"
  description    = "The CodeBuild project for ${var.repo_name}"
  service_role   = aws_iam_role.codebuild_assume_role.arn
  build_timeout  = var.build_timeout

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type    = var.build_compute_type
    image           = var.build_image
    type            = "LINUX_CONTAINER"
    privileged_mode = var.build_privileged_override
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = var.buildspec_apply
  }
}