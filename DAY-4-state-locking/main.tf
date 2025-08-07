resource "aws_instance" "name" {
    ami = "ami-0d54604676873b4ec"
    instance_type = "t2.nano"
    tags = {

        Name="ec5"

    }
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name="vpc12"
    }
  


}
   
}
