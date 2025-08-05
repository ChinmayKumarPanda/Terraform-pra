output "public_ip" {
  description = "Public IP address of the instance"
  value       = aws_instance.Name.public_ip
}

output "private_ip" {
  description = "Private IP address of the instance"
  value       = aws_instance.Name.private_ip
}
