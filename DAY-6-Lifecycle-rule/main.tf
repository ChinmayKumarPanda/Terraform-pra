resource "aws_instance" "name" {
ami = "ami-0f918f7e67a3323f0"
instance_type = "t2.micro"
lifecycle {
  prevent_destroy = false
  create_before_destroy = true
 ignore_changes = [ tags, ]
}
tags = {
  Name= "ec2"
}
}
