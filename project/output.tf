# ---------------- VPC Outputs ----------------
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnets"
  value       = module.vpc.private_subnets
}

output "default_security_group_id" {
  description = "Default VPC security group"
  value       = module.vpc.default_security_group_id
}

# ---------------- EC2 Outputs ----------------
output "public_ec2_id" {
  description = "ID of the public EC2 instance"
  value       = module.ec2_public.id
}

output "public_ec2_private_ip" {
  description = "Private IP of the public EC2 instance"
  value       = module.ec2_public.private_ip
}

output "public_ec2_public_ip" {
  description = "Public IP of the public EC2 instance"
  value       = module.ec2_public.public_ip
}

output "private_ec2_id" {
  description = "ID of the private EC2 instance"
  value       = module.ec2_private.id
}

output "private_ec2_private_ip" {
  description = "Private IP of the private EC2 instance"
  value       = module.ec2_private.private_ip
}

# ---------------- RDS Outputs ----------------
output "db_instance_identifier" {
  description = "RDS instance identifier"
  value       = module.db.db_instance_identifier
}

output "db_instance_address" {
  description = "DNS address of the RDS instance"
  value       = module.db.db_instance_address
}

output "db_instance_endpoint" {
  description = "RDS endpoint (hostname + port)"
  value       = module.db.db_instance_endpoint
}

output "db_instance_port" {
  description = "Port of the RDS instance"
  value       = module.db.db_instance_port
}

output "db_instance_username" {
  description = "Master username for RDS"
  value       = module.db.db_instance_username
  sensitive   = true
}
