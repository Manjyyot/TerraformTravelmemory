output "mongodb_instance_id" {
  value = aws_instance.mongodb_server.id
}

output "frontend_instance_id" {
  value = aws_instance.frontend_server.id
}

output "backend_instance_id" {
  value = aws_instance.backend_server.id
}
