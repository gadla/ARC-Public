resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "ARC_main_vpc"
  }
}

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

# resource "aws_subnet" "main_subnet" {
#   count = length(var.subnet_cidrs)

#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = var.subnet_cidrs[count.index]
#   map_public_ip_on_launch = true

#   tags = {
#     Name = var.subnet_names[count.index]
#   }
# }

resource "aws_subnet" "firewall_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.firewall_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "FirewallSubnet"
  }
}
resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MainIGW"
  }
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "MainRouteTable"
  }
}

resource "aws_route_table" "rt_windows" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #gateway_id = aws_internet_gateway.main_igw.id
    gateway_id = aws_networkfirewall_firewall.ARC_Firewall.id
  }

  tags = {
    Name = "rt-windows"
  }
}

resource "aws_route_table" "rt_linux" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_networkfirewall_firewall.ARC_Firewall.id
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

# resource "aws_route_table_association" "main_rta" {
#   count = length(var.subnet_cidrs)

#   subnet_id      = aws_subnet.main_subnet[count.index].id
#   route_table_id = aws_route_table.main_rt.id
# }


