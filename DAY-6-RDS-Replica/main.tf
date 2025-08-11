#VPC
resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "DEV_vpc"
  }
}
#SUBNETS
resource "aws_subnet" "PUB" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    tags = {
      Name = "PUB_sub"
    }
}

resource "aws_subnet" "PVT1" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"   # AZ1
  tags = {
    Name = "PVT_sub1"
  }
}

resource "aws_subnet" "PVT2" {
  vpc_id            = aws_vpc.name.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1b"   # AZ2
  tags = {
    Name = "PVT_sub2"
  }
}

#IGW
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "IGW"
    }
  
}
#Elastic IP
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "eip"
  }
}
#NAT
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.PUB.id
  tags = {
    Name = "CUST_NAT"
  }
}
#RT
resource "aws_route_table" "PUB" {
  vpc_id = aws_vpc.name.id
 tags = {
   Name = "RT(pub)"
 }
}

resource "aws_route_table" "PVT" {
  vpc_id = aws_vpc.name.id
  tags = {
  Name = "RT(pvt)"
 }
}

#ROUTE
resource "aws_route" "PUB" {
gateway_id = aws_internet_gateway.name.id
route_table_id = aws_route_table.PUB.id
destination_cidr_block = "0.0.0.0/0"
 
}
resource "aws_route" "PVT" {  
    nat_gateway_id = aws_nat_gateway.nat.id
    route_table_id = aws_route_table.PVT.id
    destination_cidr_block = "0.0.0.0/0"
}
#RT Association
resource "aws_route_table_association" "PUB" {
    subnet_id = aws_subnet.PUB.id
    route_table_id =aws_route_table.PUB.id

    }

 resource "aws_route_table_association" "PVT" {
  subnet_id = aws_subnet.PVT1.id
  route_table_id =aws_route_table.PVT.id

    }
# SG
  resource "aws_security_group" "RDS_sg" {
  name        = "RDS-sg"
  description = "RDS"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-sg"
  }
}


# DB Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.PVT1.id,
    aws_subnet.PVT2.id
  ]

  tags = {
    Name = "RDS Subnet Group"
  }
}


# Primary RDS Instance 
resource "aws_db_instance" "primary" {
  identifier              = "admin"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "cloud123"
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  availability_zone       = "ap-south-1a"
  skip_final_snapshot     = true
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.RDS_sg.id]
  backup_retention_period = 1   # Enables automated backups
}


resource "aws_db_instance" "replica" {
  identifier             = "my-read-replica"
  replicate_source_db    = aws_db_instance.primary.identifier
  instance_class         = "db.t3.micro"
  publicly_accessible    = false
  availability_zone      = "ap-south-1b"  # different AZ than primary
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.RDS_sg.id]

  depends_on = [aws_db_instance.primary]
}

