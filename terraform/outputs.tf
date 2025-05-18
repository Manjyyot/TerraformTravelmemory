output "mongodb_instance_ip" {
  value = aws_instance.mongodb_server.public_ip
}

output "frontend_instance_ip" {
  value = aws_instance.frontend_server.public_ip
}

output "backend_instance_ip" {
  value = aws_instance.backend_server.public_ip
}
