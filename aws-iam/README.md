# AWS IAM module

  * [Users (console login)](#users-console-login)
     * [Arguments](#arguments)
     * [Example User with login](#example-user-with-login)
  * [Users (service accounts)](#users-service-accounts)
    * [Arguments](#arguments-1)
    * [Example CircleCI service account with S3 access](#example-circleci-service-account-with-s3-access)
  * [Groups](#groups)
     * [Arguments](#arguments-2)
     * [Example Admins group with required MFA enabled](#example-admins-group-with-required-mfa-enabled)
  * [Roles](#roles)
     * [Arguments](#arguments-3)
     * [Example Execute Lambda function role](#example-execute-lambda-function-role)


## Users (console login)
Users created with a login profile to the AWS console. Useful for humans e.g. developers.

### Arguments
- `name`: (Required) The user's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both `"TESTUSER"` and `"testuser"`.
- `pgp_key`: (Required) Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Only applies on resource creation. Drift detection is not possible with this argument.
- `force_destroy`: (Optional, default true) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed.
- `password_reset_required`: (Optional, default true) Whether the user should be forced to reset the generated password on resource creation. Only applies on resource creation. Drift detection is not possible with this argument.
- `groups`: "(Optional) A list of IAM Groups to add the user to."

### Example User with login
```hcl-terraform
module "test_user" {
  source                  = "git@github.com:starcity-properties/terraform-modules.git//aws-iam/login-user?"
  name                    = "test_user"
  pgp_key                 = var.pgp_key
}
```

## Users (service accounts)
Users created with a pair of access keys, but without a login profile to the AWS Console. Useful for services. 

**Note**: The user's name will be created with `-sa` attached at the end.

### Arguments
- `name`: (Required) The user's name which will have `"-sa"` added at the end. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both `"TESTUSER"` and `"testuser"`.
- `pgp_key`: (Required) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:username. Only applies on resource creation. Drift detection is not possible with this argument.
- `force_destroy`: (Optional, default true) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed.
- `policies`: (Optional, default []). List of policiy ARNs to attach to the group.
- `policy_documents`: (Optional, default []). List of policiy documents to attach to the group. Read more about policy documents at [AWS IAM Policy Documents with Terraform](https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html).

### Example CircleCI service account with S3 access

IAM policy `policies/circleci.json`:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowS3FullAccess",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
```
IAM user with created access keys:
```hcl-terraform
data "template_file" "circleci-policy" {
  template = file("policies/circleci.json")
}

module "circleci-sa" {
  source  = "git@github.com:starcity-properties/terraform-modules.git//aws-iam/sa-user"
  name    = "circleci"
  pgp_key = var.pgp_key
  policy_documents = [
    data.template_file.circleci-policy.rendered
  ]
}
```

## Groups

### Arguments
- `name`: (Required) The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. Group names are not distinguished by case. For example, you cannot create groups named both `"ADMINS"` and `"admins"`.
- `path`: (Optional, default `"/"`) Path in which to create the group.
- `policies`: (Optional, default []). List of policiy ARNs to attach to the group.
- `policy_documents`: (Optional, default []). List of policiy documents to attach to the group. Read more about policy documents at [AWS IAM Policy Documents with Terraform](https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html).

### Example Admins group with required MFA enabled
IAM policy to require MFA to be enabled for access: `policies/mfa.json`:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowViewAccountInfo",
      "Effect": "Allow",
      "Action": [
        "iam:GetAccountPasswordPolicy",
        "iam:ListVirtualMFADevices"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowManageOwnVirtualMFADevice",
      "Effect": "Allow",
      "Action": [
        "iam:CreateVirtualMFADevice",
        "iam:DeleteVirtualMFADevice"
      ],
      "Resource": "arn:aws:iam::*:mfa/$${aws:username}"
    },
    {
      "Sid": "AllowManageOwnUser",
      "Effect": "Allow",
      "Action": [
        "iam:DeactivateMFADevice",
        "iam:EnableMFADevice",
        "iam:GetUser",
        "iam:ListMFADevices",
        "iam:ResyncMFADevice",
        "iam:ChangePassword"
      ],
      "Resource": "arn:aws:iam::*:user/$${aws:username}"
    },
    {
      "Sid": "DenyAllExceptListedIfNoMFA",
      "Effect": "Deny",
      "NotAction": [
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:GetUser",
        "iam:ListMFADevices",
        "iam:ListVirtualMFADevices",
        "iam:ResyncMFADevice",
        "sts:GetSessionToken"
      ],
      "Resource": "*",
      "Condition": {
        "BoolIfExists": {"aws:MultiFactorAuthPresent": "false"}
      }
    }
  ]
}
```
IAM Group for admin access when MFA is enabled:
```hcl-terraform
module "admins-group" {
  source = "git@github.com:starcity-properties/terraform-modules.git//aws-iam/group"
  name   = "admins"
  path   = "/users/"
  policies = [
    "arn:aws:iam::aws:policy/AdministratorAccess"
  ]
  policy_documents = [
    data.template_file.mfa-policy-template.rendered
  ]
}
```

## Roles

### Arguments
- `name`: (Required) The name of the role.
- `environment`: (Required) Environment function is running in e.g. "production" or "staging".
- `identifiers`: (Required) List of identifiers for principals. When type is `"AWS"`, these are IAM user or role ARNs. When type is `"Service"`, these are AWS Service roles e.g. lambda.amazonaws.com.
- `policies`: (Optional, default []). List of policiy ARNs to attach to the role.
- `policy_documents`: (Optional, default []). List of policiy documents to attach to the role. Read more about policy documents at [AWS IAM Policy Documents with Terraform](https://www.terraform.io/docs/providers/aws/guides/iam-policy-documents.html).


### Example Execute Lambda function role 
```hcl-terraform
module "lambda_role" {
  source      = "git@github.com:starcity-properties/terraform-modules.git//aws-iam/role"
  environment = "production"
  identifiers = ["lambda.amazonaws.com"]
  name        = "lambda-basic-role"
  type        = "Service"
  policies    = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}
```