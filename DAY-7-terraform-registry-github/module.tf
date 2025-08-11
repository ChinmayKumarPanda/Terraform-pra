provider "aws" {
  region = "ap-south-1"
}

module "TEST" {
  source        = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"
  ami           = "ami-0d54604676873b4ec"
  instance_type = "t2.micro"
  subnet_id     = "subnet-077879ee383da87f0"
  name = "server"
  
  
}
