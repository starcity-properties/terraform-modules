# AWS ECS module
Module for creating a running AWS ECS cluster and related tools such as ALB, CloudWatch, and IAM resources.

## Table of Contents
  * [Overview](#overview)
  * [Arguments](#arguments)
  * [Outputs](#outputs)
  * [Example](#example)
  * [Resources](#resources)

## Overview
Using this module will spin up everything needed to have a web application deployed on ECS.
- Application Load Balancer - redirecting from HTTP to HTTPS and routing traffic to the web application running in ECS. Necessary security groups, target groups and listeners are configured.
  - Access logs will be printed to the specified log bucket.
  - Health check performed as specified
- ECS - cluster, service, task definition and a dummy task starting a simple server. Your CD pipeline can create new revisions of the task definition with the relevant Docker images, as well as register the task definition with the service and update the service to force a new deployment.
- CloudWatch - event rules for filtering ECS task state changes to `RUNNING` and `STOPPED`. These can be used to notify on failed/successful deployments.


## Arguments
- `region` - (Required) AWS region
- `environment` - (Required) Environment (e.g. staging, production)
- `application` - (Required) The name of the application/project (up to 255 letters, numbers, hyphens, and underscores)
- `acm_arn` - (Required) The ARN of the default SSL server certificate.
- `log_bucket` - (Required) The S3 bucket name to store the ALB access logs in.
- `vpc_id` - (Required, Forces new resource) The identifier of the VPC in which to create the target group and security groups.
- `public_subnet_ids` - (Required) A list of subnet IDs to attach to the ALB.
- `private_subnet_ids` - (Required) A list of subnet IDs associated with the ECS service.
- `security_groups` - (Optional) The security groups associated with the ECS service.
- `alb_health_check` - (Optional) A Health Check block.
  - `interval` - (Optional) The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default value is `10`.
  - `path` - (Optional) The destination for the health check request. Default value is `/`.
  - `matcher` - (Optional) The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299"). Default value is `"200"`.
  - `healthy_threshold` - (Optional) The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to `2`.
  - `unhealthy_threshold` - (Optional) The number of consecutive health check failures required before considering the target unhealthy. Defaults to `2`.
- `port` - (Required) The host port on which to access the web server. Will be mapped to `container_port`.
- `container_port` - (Required) The container port where the web server runs.
- `cpu` - (Optional) The number of cpu units used by the task. Default value is `1024`.
- `memory` - (Optional) The amount (in MiB) of memory used by the task. Default value is `2048`.

## Outputs
- `sg_id` - Id of the security group created for the Application Load Balancer.
- `cloudwatch_event_rule_running_ecs` - Event rule for filtering CloudWatch events based on ECS task state changed to `RUNNING`. See [Terraform Resource: aws_cloudwatch_event_rule Attributes Reference](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#attributes-reference) for details on the output attributes.
- `cloudwatch_event_rule_failed_ecs` - Event rule for filtering CloudWatch events based on ECS task state changed to `STOPPED`. More details in [Terraform Resource: aws_cloudwatch_event_rule Attributes Reference](https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_rule.html#attributes-reference).

## Example
```hcl-terraform
module "my-ecs" {
  source      = "git@github.com:starcity-properties/terraform-modules.git//aws-ecs?ref=1.1.0"

  region      = "us-west-2"
  environment = "production"
  application = "my_application"

  vpc_id             = "vpc-12345abcd"
  private_subnet_ids = ["subnet-1a2b3c", "subnet-3c2b1a"]
  public_subnet_ids  = ["subnet-2b3c4d", "subnet-4d3c2b"]
  security_groups    = ["sg-111aaa"]

  port             = 3000
  container_port   = 3000
  cpu              = 4096
  memory           = 8192

  acm_arn          = "arn:aws:acm:us-west-2:0123456789abc:certificate/abc"
  log_bucket       = "com.my_application.logs"
}
```

## Resources
- [Terraform AWS Provider documentation](https://www.terraform.io/docs/providers/aws/)