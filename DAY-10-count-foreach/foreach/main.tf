resource "aws_instance" "name" {
    ami = "ami-0861f4e788f5069dd"
   instance_type = "t2.micro"
    for_each = toset(var.ec2)
    tags = {
      Name = each.value
    }
}

  variable "ec2" {
    type = list(string)
    default = [ "dev","prod" ]
  
}