# Creation of my VPC
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ARC_main_vpc"
  }
}

# Subnet creation
resource "aws_subnet" "Windows_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidrs[0]
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_names[0]
  }
}

resource "aws_subnet" "Linux_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.subnet_cidrs[1]
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet_names[1]
  }
}

resource "aws_subnet" "firewall_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.firewall_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "FirewallSubnet"
  }
}

# Internet Gateway creation
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MainIGW"
  }
}

# Route table creation
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "FirewallRouteTable"
  }
}

resource "aws_route_table" "rt_windows" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
    #gateway_id = aws_networkfirewall_firewall.main_firewall.id
  }

  tags = {
    Name = "rt-windows"
  }
}

resource "aws_route_table" "rt_linux" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.main_igw.id
    gateway_id = aws_networkfirewall_firewall.main_firewall.id
  }

  tags = {
    Name = "rt-linux"
  }
}

# Creating route table association for each subnet
resource "aws_route_table_association" "rta_linux" {
  subnet_id      = aws_subnet.Linux_subnet.id
  route_table_id = aws_route_table.rt_linux.id
}
resource "aws_route_table_association" "rt_windows" {
  subnet_id      = aws_subnet.Windows_subnet.id
  route_table_id = aws_route_table.rt_windows.id
}

resource "aws_route_table_association" "rta_firewall" {
  subnet_id      = aws_subnet.firewall_subnet.id
  route_table_id = aws_route_table.main_rt.id
}

# associate security group with vpc
