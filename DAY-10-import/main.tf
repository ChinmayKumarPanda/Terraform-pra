resource "aws_instance" "name" {
  ami = "ami-0861f4e788f5069dd"
  instance_type = "t2.micro"
  lifecycle {
    
    ignore_changes = [ tags, ]
}
tags = {
  Name= "ec245"
}
}
resource "aws_s3_bucket" "name" {
  bucket = "mybuckets3demo00"
  
}

resource "aws_iam_user" "name" {
  name = "thuder"
}
