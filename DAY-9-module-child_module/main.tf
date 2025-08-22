module "ec2" {
    source = "./Modules/ec2"
    ami = var.ami
    instance_type =var.instance_type 
   tags = var.tags
}

module "s3" {
    source = "./Modules/s3"
    s3 = var.s3

  
}
module "aws_vpc" {
    source = "./Modules/vpc"
    cidr_block = var.cidr_block
    tags_vpc = var.tags_vpc
    cidr_blocks =   var.cidr_blocks
    tags_subnet = var.tags_subnet
}

module "aws_db_instance" {
    source = "./Modules/rds"
    db_identifier = var.db_identifier
    db_username = var.db_username
    db_password = var.db_password
  
}