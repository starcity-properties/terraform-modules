# AWS ECR module

Module for creating [AWS ECR](https://aws.amazon.com/ecr/) resources

## Arguments
- **`name`** - (Required) Name of the repository.
- **`environment`** - (Required) AWS environment (e.g. staging, production).

## Outputs
- **`ecr_url`** - The URL of the repository (in the form `aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName`)

## Example
```hcl-terraform
module "example-ecr" {
  source      = "git@github.com:starcity-properties/terraform-modules.git//aws-ecr?ref=1.0.0"
  name        = "example_repo"
  environment = "production"
}
```

## Resources
- [AWS ECR User Guide](https://docs.aws.amazon.com/AmazonECR/latest/userguide/what-is-ecr.html)
- [Terraform Resource: aws_ecr_repository](https://www.terraform.io/docs/providers/aws/r/ecr_repository.html)