resource "aws_instance" "name" {
    ami = "ami-0d54604676873b4ec"
    instance_type = "t2.micro"
    tags = {
<<<<<<< HEAD
        Name="dev"
=======
        Name="ec4"
>>>>>>> 8c2b4cfdea7424797f1f9c99cec370897e5a7082
    }
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="vpc12"
    }
  
}
