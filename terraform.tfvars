aws_region           = "us-west-2" # Example region
vpc_cidr             = "10.0.0.0/16"
subnet_cidrs         = ["10.0.1.0/24", "10.0.2.0/24"] # Example subnets
subnet_names         = ["Windows_subnet", "Linux_subnet"]
firewall_subnet_cidr = "10.0.100.0/24"
firewall_subnet_name = "arc-Firewall-Subnet"
firewall_name        = "arc-Firewall"
