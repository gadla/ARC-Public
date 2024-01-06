# Define the AWS Network Firewall Resource
resource "aws_networkfirewall_firewall" "main_firewall" {
  name                = "my-firewall"
  firewall_policy_arn = aws_networkfirewall_firewall_policy.example.arn
  vpc_id              = aws_vpc.main_vpc.id
  subnet_mapping {
    subnet_id = aws_subnet.firewall_subnet.id # Reference to your existing firewall subnet
  }

  # Optionally, define tags here
  tags = {
    Name = "MyFirewall"
  }
}

# Define the Firewall Policy
resource "aws_networkfirewall_firewall_policy" "example" {
  name = "example"

  firewall_policy {
    stateless_default_actions          = ["aws:pass"]
    stateless_fragment_default_actions = ["aws:pass"]
    # Add more policy rules as needed
  }
}

# Add any additional configurations or logging as required
