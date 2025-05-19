# Public IPs
output "frontend_instance_ip" {
  description = "Public IP of the frontend server"
  value       = aws_instance.frontend_server.public_ip
}

output "backend_instance_ip" {
  description = "Public IP of the backend server"
  value       = aws_instance.backend_server.public_ip
}

output "mongodb_instance_ip" {
  description = "Public IP of the MongoDB server"
  value       = aws_instance.mongodb_server.public_ip
}

# Instance IDs
output "frontend_instance_id" {
  description = "Instance ID of the frontend server"
  value       = aws_instance.frontend_server.id
}

output "backend_instance_id" {
  description = "Instance ID of the backend server"
  value       = aws_instance.backend_server.id
}

output "mongodb_instance_id" {
  description = "Instance ID of the MongoDB server"
  value       = aws_instance.mongodb_server.id
}

# Networking Info
output "security_group_id" {
  description = "Security group used for EC2 instances"
  value       = var.security_group_id
}

output "subnet_id" {
  description = "Subnet where EC2 instances are deployed"
  value       = var.subnet_id
}

output "vpc_id" {
  description = "VPC used for EC2 instances"
  value       = var.vpc_id
}
