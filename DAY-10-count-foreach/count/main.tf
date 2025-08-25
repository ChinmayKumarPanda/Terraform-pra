#resource "aws_instance" "name" {
    #ami = "ami-0861f4e788f5069dd"
   #instance_type = "t2.micro"
    #count = "2"                      ######for default tags names ex-  test-0 ,test-1
  #tags = {
   # Name = "test-${count.index}"
  #}
#}

resource "aws_instance" "name" {
    ami = "ami-0861f4e788f5069dd"
   instance_type = "t2.micro"
    count = length(var.ec2)                    
  tags = {
    Name = var.ec2[count.index]
  }
}


variable "ec2" {
    type = list(string)
    default = [ "dev","test","prod" ]
  
}