provider "aws" {
region = "ap-south-1"
}

resource "aws_key_pair" "name" {
    key_name = "aws"
    public_key = file("~/.ssh/id_ed25519.pub")
  
}


resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  tags = {
    Name = "MyVPC"
  }
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}


resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "SG" {
  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

  resource "aws_instance" "server" {
  ami = "ami-02d26659fd82cf299" 
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.name.key_name
  subnet_id                   = aws_subnet.sub1.id
  vpc_security_group_ids      = [aws_security_group.SG.id]
  associate_public_ip_address = true

  tags = { Name = "ec2" }

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"                        
#     private_key = file("~/.ssh/id_ed25519")          # ensure it matches the key pair
#     host        = self.public_ip
#     timeout     = "2m"
#   }

#  provisioner "file" {
#   source      = "file10"     
#   destination = "/home/ubuntu/file10"
# }

#   provisioner "remote-exec" {
#     inline = [
#       "touch /home/ubuntu/file200",
#       "echo 'hello from multicloud' >> /home/ubuntu/file200"
#     ]
#   }

#   provisioner "local-exec" {
#     command = "type nul > file500"                   # Windows-friendly; use `touch` on Linux/macOS
#   }
}

resource "null_resource" "name" {
  provisioner "remote-exec" {
    connection {
    user        = "ubuntu"                        
    private_key = file("~/.ssh/id_ed25519")          # ensure it matches the key pair
    host        = aws_instance.server.public_ip
  
  }
inline = [
      "echo 'hello from multi' >> /home/ubuntu/file200"
    ]
    
  }
    triggers = {
    always_run = "${timestamp()}" # Forces rerun every time
  }
}