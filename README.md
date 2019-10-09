# Starcity Terraform Modules

This repository houses a collection of reusable Terraform modules to create AWS resources

  * [Overview](#overview)
     * [Versioning](#versioning)
  * [Modules](#modules)


## Overview
### Versioning
To allow for making changes without breaking dependencies, we version every change to the modules by git tagging every merged commit. We do a slightly modified [semver](https://semver.org/) versioning; 
- `MINOR` for non-breaking changes, e.g. adding new resources or refactoring. 
- `MAJOR` for breaking changes, e.g. changing existing resources or removing resources.

Note that we don't use the `PATCH`, however we do still include it in the git tag in case it could be useful in the future. 

Tagging a new version (e.g. `1.1.0`:
```bash
git checkout master
git pull --rebase
git tag 1.1.0
git push --tags
```

## Modules
See more detailed documentation for each resource:

* [AWS EC2](https://github.com/starcity-properties/terraform-modules/tree/master/aws-ec2)
* [AWS ECR](https://github.com/starcity-properties/terraform-modules/tree/master/aws-ecr)
* [AWS ECS](https://github.com/starcity-properties/terraform-modules/tree/master/aws-ecs)
* [AWS IAM](https://github.com/starcity-properties/terraform-modules/tree/master/aws-iam)