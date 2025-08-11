module "name" {
  source = "../DAY-7-example-1"
  ami = "ami-0d54604676873b4ec"
  instance_type = "t2.micro"
  tags = "server"
  profile = "TESTING"
}