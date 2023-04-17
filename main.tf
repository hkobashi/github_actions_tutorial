### reference
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider
###
resource "aws_iam_openid_connect_provider" "import" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com",
  ]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

### reference
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
###
resource "aws_iam_role" "edited"{
  name = "githubactions_role"
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
				"Federated": "arn:aws:iam::161833304357:oidc-provider/token.actions.githubusercontent.com"
			},
			"Action": "sts:AssumeRoleWithWebIdentity",
			"Condition": {
				"StringEquals": {
					"token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
					"token.actions.githubusercontent.com:sub": [
            "repo:hkobashi-organization/check_secrets"
          ]
				}
			}
		}
	]
})
}