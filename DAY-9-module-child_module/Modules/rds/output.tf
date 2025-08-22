output "rds_endpoint" {
  description = "RDS connection endpoint"
  value       = aws_db_instance.default.endpoint
}

output "rds_address" {
  description = "RDS hostname"
  value       = aws_db_instance.default.address
}

output "rds_port" {
  description = "RDS port"
  value       = aws_db_instance.default.port
}
