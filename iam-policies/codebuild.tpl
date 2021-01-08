{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
       "s3:*"
      ],
      "Resource": [
        "${artifact_bucket}",
        "${artifact_bucket}/*",
        "${backend_bucket}",
        "${backend_bucket}/*"
      ],
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Resource": [
        "${codebuild_terraform_plan}",
        "${codebuild_terraform_apply}"
      ],
      "Action": [
        "codebuild:*"
      ]
    },
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    }
  ]
}