resource "aws_instance" "name" {
ami = "ami-0d54604676873b4ec"
instance_type = "t2.micro"
user_data = file("index.ssh")
tags = {
  Name= "ec2"
}
}