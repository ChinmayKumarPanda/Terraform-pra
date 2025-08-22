module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # Always pin module version

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true   # Allow private instances internet access
  enable_vpn_gateway = true   # Optional, for hybrid setup (on-premises VPN)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Public EC2 Instance
module "ec2_public" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = "my-public-instance"
  ami           = "ami-08e5424edfe926b43" # Change to region-specific AMI
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]  # Place in public subnet

  vpc_security_group_ids = [module.vpc.default_security_group_id]

  associate_public_ip_address = true  # ✅ Ensure public instance gets a public IP

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Role        = "Public-EC2"
  }
}

# Private EC2 Instance
module "ec2_private" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name          = "my-private-instance"
  ami           = "ami-08e5424edfe926b43" # Change to region-specific AMI
  instance_type = "t2.micro"
  subnet_id     = module.vpc.private_subnets[0]  # Place in private subnet

  vpc_security_group_ids = [module.vpc.default_security_group_id]

  associate_public_ip_address = false  # ✅ No public IP (private instance)

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Role        = "Private-EC2"
  }
}
module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "admin"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  password = "cloud123"   # 🔑 Master DB password
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [module.vpc.default_security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  create_db_subnet_group = true

subnet_ids = [
  module.vpc.private_subnets[0],
  module.vpc.private_subnets[1]
]


  family                 = "mysql5.7"
  major_engine_version   = "5.7"

  deletion_protection    = false
}
