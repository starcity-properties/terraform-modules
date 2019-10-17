# AWS RDS module
Module for creating an RDS instance.

## Usage

### Arguments 

| | |
| ----------- | ----------- |
| `allocated_storage` | The allocated storage in gibibytes. |
| `application` | Used as name prefix for the instance. |
| `backup_retention_period` | The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica. See Read Replica. |
| `backup_window` | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: "09:46-10:16". |
| `db_port` |  Port for ingress. |
| `ec2_sg` | Security groups attached to EC2 instances that need RDS access. |
| `engine` | The database engine to use. For supported values, see the Engine parameter in [API action CreateDBInstance](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html). |
| `engine_version` | The engine version to use. If auto_minor_version_upgrade is enabled, you can provide a prefix of the version such as 5.7 (for 5.7.10) and this attribute will ignore differences in the patch version automatically (e.g. 5.7.17). For supported values, see the EngineVersion parameter in [API action CreateDBInstance](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html). |
| `environment` | AWS environment (e.g. staging/production). |
| `instance_class` | The instance type of the RDS instance. |
| `name` | The name of the database to create when the DB instance is created. |
| `password` | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file. |
| `private_subnet_id` | A list of VPC subnet IDs to create an RDS subnet group with. |
| `storage_type` | One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD). The default is "io1" if iops is specified, "gp2" if not. |
| `username` | Username for the master DB user. |
| `vpc_id` | The VPC ID for the security group created for RDS access. |

### Outputs
|  |  |
| ----------- | ----------- |
| `rds_address` |  The hostname of the RDS instance. See also `rds_endpoint` and `rds_port`. |
| `rds_endpoint` | The connection endpoint in address:port format. |
| `rds_port` | The database port. |


### Example RDS instance

```terraform
module "example-postgres" {
  source            = "git@github.com:starcity-properties/terraform-modules.git//aws-rds?ref=1.5.0"
  environment       = "production"
  application       = "postgres"
  private_subnet_ids = ["subnet-00aabb", "subnet-11bbcc"]
  vpc_id            = "vpc-123abc"
  storage_type      = "gp2"
  instance_class    = "db.t2.small"
  allocated_storage = "25"

  engine         = "postgres"
  engine_version = "11.2"

  username = "postgres"
  password = "password"

  db_port = 5432
  ec2_sg  = "sg-12345"
}
```