# --- VPC ---
resource "aws_vpc" "mon_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true #active DNS
  enable_dns_hostnames = true #Active noms DNS interne
 
  tags = {
    Name = "vpc"
  }
}
 
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.mon_vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true #Avoir une IP public
 
  tags = {
    Name = "tp-public-subnet"
  }
}
 
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.mon_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-1b"
 
  tags = {
    Name = "tp-private-subnet"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.mon_vpc.id

  tags = {
    Name = "tp-gateway"
  }
}

# Table de routage : comment le trafic réseau est dirigé
resource "aws_route_table" "public_table" {
  vpc_id = aws_vpc.mon_vpc.id

  tags = {
    Name = "tp-public-table"
  }
}

#Route vers internet
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

#Association table de routage avec subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_table.id
}

# Groupe de sécurité
resource "aws_security_group" "groupe_securite_web" {
  name        = "groupe_securite_web"
  description = "Autorise trafic HTTP port 80 + SSH"
  vpc_id      = aws_vpc.mon_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#autorise toutes les connexions sortantes depuis les instances
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
