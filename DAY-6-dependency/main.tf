resource "aws_instance" "name" {
  ami           = "ami-0d54604676873b4ec"
  instance_type = "t2.micro"
  depends_on = [ aws_db_instance.name ,aws_s3_bucket.name ] 
  tags = {
    Name = "ec2"
  }
}

resource "aws_s3_bucket" "name" {
  bucket     = "qwsdfbn"
}

resource "aws_db_instance" "name" {
  allocated_storage    = 20
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "cloud123"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  
}
