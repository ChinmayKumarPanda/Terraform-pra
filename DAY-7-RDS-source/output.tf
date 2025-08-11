output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.name.endpoint
}

output "rds_port" {
  description = "The port the RDS instance is listening on"
  value       = aws_db_instance.name.port
}

output "rds_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.name.arn
}