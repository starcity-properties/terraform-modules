# AWS Bastion module
Module for creating a Bastion instance.

## Usage

### Arguments
| | | 
| --- | --- |
| `ami` | The AMI to use for the instance.
| `bastion_cidr_blocks` | List of IPs allowed to SSH into the Bastion host.
| `environment` | AWS environment (e.g. staging/production).
| `instance_type` | The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance.
| `key_name` | The key name of the Key Pair to use for the instance; which can be managed using the [`aws_key_pair` resource](https://www.terraform.io/docs/providers/aws/r/key_pair.html).
| `security_groups` | List of security groups to add to the Bastion host.
| `subnet_id` | The VPC Subnet ID to launch in.
| `vpc_id` | The VPC ID of the security group for SSH access.

### Outputs 
| | | 
| --- | --- |
| `sg_id` | Security group ID of the bastion instance. 
