#AWS Provider Creation
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#AWS APP VPC
resource "aws_vpc" "vpc_devops" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  instance_tenancy     = var.instance_tenancy

  tags = {
    Name = "vpc_devops"
  }
}

#AWS App Subnet
resource "aws_subnet" "sub_public_devops" {
  vpc_id                  = aws_vpc.vpc_devops.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az1a
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "sub_public_devops"
  }
}

#AWS Route Table for App
resource "aws_route_table" "route_tbl_devops" {
  vpc_id = aws_vpc.vpc_devops.id

  route {
    cidr_block = var.all_cidrs
    gateway_id = aws_internet_gateway.igw_devops.id
  }
  tags = {
    Name = "AWS Route Table"

  }

}

#Associate App subnet1 with route table
resource "aws_route_table_association" "route_tbl_associat" {
  subnet_id      = aws_subnet.sub_public_devops.id
  route_table_id = aws_route_table.route_tbl_devops.id
}

#AWS Internet Gateway
resource "aws_internet_gateway" "igw_devops" {
  vpc_id = aws_vpc.vpc_devops.id

  tags = {
    Name = "igw_devops"
  }
}

#AWS App Security Group
resource "aws_security_group" "sg_devops" {
  name        = var.sg_name
  description = "AwS Security group"
  vpc_id      = aws_vpc.vpc_devops.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = var.tcp_protocal
    cidr_blocks = [var.all_cidrs]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = var.tcp_protocal
    cidr_blocks = [var.all_cidrs]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.tcp_protocal
    cidr_blocks = [var.all_cidrs]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidrs]
  }

}

#Create private key which can be used to login webserver
resource "tls_private_key" "tls-pvt-key" {
  algorithm = var.algorithm
}

#Save Public key attribute from the generated key
resource "aws_key_pair" "key-pair" {
  key_name   = var.ssh_key
  public_key = tls_private_key.tls-pvt-key.public_key_openssh
}

#Save the key to the local system
resource "local_file" "kp-devops" {
  content  = tls_private_key.tls-pvt-key.private_key_pem
  filename = var.ssh_key_name
}

resource "aws_instance" "ec2_devops" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.sub_public_devops.id
  key_name                    = var.ssh_key
  security_groups             = [aws_security_group.sg_devops.id]
  private_ip                  = var.private_ip
  associate_public_ip_address = true

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = var.delete_on_termination
  }

  tags = {
    Name = "Private IP"
  }

}

resource "aws_eip" "eip_devops" {
  instance = aws_instance.ec2_devops.id
  vpc      = var.vpc

}
