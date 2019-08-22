output "ec2_sg" {
  description = "Outputs the value of the EC2 security group"
  value       = aws_security_group.aws-sg.id
}

