variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "us-east-1" # Replace with your preferred AWS region if needed
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
}

variable "windows_ami_id" {
  description = "The AMI ID for Windows instances"
  type        = string
  default     = "ami-09cd5735442e39f0d" # Replace with the actual Windows AMI ID if needed
}

variable "linux_ami_id" {
  description = "The AMI ID for Linux instances"
  type        = string
  default     = "ami-01450e8988a4e7f44" # Replace with the actual Linux AMI ID if needed
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro" # Replace with your preferred default instance type
}

variable "key_name" {
  description = "Key pair for ec2 instances"
  type        = string
  default     = "aws_key_pair"
}

variable "subnet_names" {
  description = "Names for the subnets"
  type        = list(string)
}

variable "firewall_subnet_cidr" {
  description = "CIDR block for the firewall subnet"
  type        = string
}

variable "firewall_subnet_name" {
  description = "Name for the firewall subnet"
  type        = string
}

variable "firewall_name" {
  description = "Name for the firewall policy"
  type        = string
}

# Add more variables as needed
