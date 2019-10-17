# AWS SNS module
Module for creating an SNS topic.

## Usage

### Arguments 

| | |
| ----------- | ----------- |
| `region` | AWS region
| `environment` | AWS environment (e.g. staging/production)
| `name` | The display name for the SNS topic, the topic name will become a combination of `name` and `environment` |

### Outputs
| | |
| ----------- | ----------- |
| `topic_arn` | The ARN of the SNS topic |


### Example SNS topic

```terraform
module "sns" {
  source      = "git@github.com:starcity-properties/terraform-modules.git//aws-sns?ref=1.3.0"
  environment = "production"
  region      = "us-west-1"
  name        = "myTopic"
} 
```