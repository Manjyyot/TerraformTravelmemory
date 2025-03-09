output "mongodb_instance_id" {
  value = aws_instance.mongodb_server.id
}

output "frontend_instance_id" {
  value = aws_instance.frontend_server.id
}

output "backend_instance_id" {
  value = aws_instance.backend_server.id
}

output "mongodb_instance_ip" {
  value = aws_instance.mongodb_server.public_ip
}

output "frontend_instance_ip" {
  value = aws_instance.frontend_server.public_ip
}

output "backend_instance_ip" {
  value = aws_instance.backend_server.public_ip
}
