module "name" {
  source = "../DAY-7-RDS-source"
  identifier              = "admin"
  allocated_storage   = 20
  db_name              = "rds"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       =  "db.t3.micro"
  username             = "admin"
  password             = "cloud123"
  skip_final_snapshot  = true
  
}