output "public_ip" {
    value = aws_instance.bastion.public_ip
}

output "private_ip" {
    value = aws_instance.bastion.private_ip
}

output "private_ip-PVT" {
    value = aws_instance.private_instance.private_ip
  
}