output "db_endpoint" {
  description = "Endpoint for DB"
  value       = aws_db_instance.ndo-mysql-stage.endpoint
}

output "db_port" {
  description = "Database port"
  value       = aws_db_instance.ndo-mysql-stage.port
}