resource "aws_instance" "windows_instance" {
  ami                    = var.windows_ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.Windows_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default_security_group.id] # Associate the security group

  tags = {
    Name = "WindowsServer"
  }
}



resource "aws_instance" "linux_instance" {
  ami                    = var.linux_ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.Linux_subnet.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default_security_group.id]
  tags = {
    Name = "LinuxServer"
  }
}
