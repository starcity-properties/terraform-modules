output "sg_id" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_security_group.bastion-sg.id
}

