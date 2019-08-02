output "rds_endpoint" {
  value = "${aws_db_instance.rds.endpoint}"
}

output "rds_address" {
  value = "${aws_db_instance.rds.address}"
}