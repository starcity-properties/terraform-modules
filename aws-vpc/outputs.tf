output "public_subnet_cidr" {
  description = "List of cidr_blocks of public subnets"
  value  = ["${aws_subnet.public-subnet.*.cidr_block}"]
}

output "public_subnet_id" {
  description = "List of id's of public subnets"
  value  = ["${aws_subnet.public-subnet.*.id}"]
}