resource "aws_instance" "name" {
ami = "ami-0d54604676873b4ec"
instance_type = "t2.micro"
tags = {
  Name= "ec2"
}
}
resource "aws_s3_bucket" "name" {
    bucket = "mybucket"
  
}
#terraform plan --target=aws_s3_bucket.name = only s3 will execution plan (Resource targeting is in effect)
#terraform plan --target=aws_instance.name = only instance will execution plan (Resource targeting is in effect)
#terraform apply -auto-approve --target=aws_instance.name = only instance will be create
#terraform destroy -auto-approve --target=aws_instance.name = only instance will be deletecd 

