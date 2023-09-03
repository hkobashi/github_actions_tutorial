# get current aws account id
data "aws_caller_identity" "current" {}

# resource "aws_s3_bucket" "backend" {
# 	bucket = "terraform-bucket-kobashikawa"
# }

### reference
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
###
resource "aws_iam_openid_connect_provider" "main" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

### reference
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
###
resource "aws_iam_role" "main"{
  name = "github_actions_role"
  max_session_duration = 3600
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  assume_role_policy = jsonencode(
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Effect": "Allow",
			"Principal": {
				"Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
			},
			"Action": "sts:AssumeRoleWithWebIdentity",
			"Condition": {
				"StringLike": {
					"token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
					"token.actions.githubusercontent.com:sub": [
						# GHAと連携したいリポジトリを指定
            "repo:hkobashi/github_actions_tutorial:*"
          ]
				}
			}
		}
	]
})
}

