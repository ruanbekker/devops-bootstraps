resource "aws_ecr_repository" "apache_httpd" {
  name                 = "httpd"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_iam_policy_document" "apache_httpd" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["111111111111", "222222222222"] # cross-account
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchDeleteImage",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:PutImage"
    ]
  }
}

resource "aws_ecr_repository_policy" "apache_httpd" {
  repository = aws_ecr_repository.apache_httpd.name
  policy     = data.aws_iam_policy_document.apache_httpd.json
}
