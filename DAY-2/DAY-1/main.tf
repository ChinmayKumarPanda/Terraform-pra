
resource "aws_instance" "name" {
  instance_type = "t2.micro"
  ami           = "ami-0d0ad8bb301edb745"

  tags = {
    Name = "custom-instance"
  }
}     