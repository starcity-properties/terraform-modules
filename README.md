# Starcity Terraform Modules

This repository houses a collection of reusable Terraform module to create AWS resources

## aws-iam-user

This module will provision an AWS IAM user and can optionally add them to an existing IAM group. `pgp_key` uses either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Usage:
```hcl
module "iam_john" {
  source      = "git@github.com:starcity-properties/terraform-modules.git//aws-iam-user?ref=master"
  aws_name    = "john"
  aws_pgp_key = "keybase:starcity"
  aws_groups  = ["developers"]
}
```

## aws-iam-group

This module will provision an AWS IAM group and will also create & attach a policy to it. Usage:
```hcl
module "iam_developers" {
  source = "git@github.com:starcity-properties/terraform-modules.git//aws-iam-group?ref=master"
  aws_group_name = "developers"
  aws_group_path = "/users/"
  aws_policy = "arn:aws:iam::aws:policy/PowerUserAccess"
}
```