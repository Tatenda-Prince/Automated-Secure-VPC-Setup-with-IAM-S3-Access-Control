resource "aws_instance" "private_ec2" {
  ami                    = "ami-08b5b3a93ed654d19" # Amazon Linux 2 AMI (Change as needed)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  associate_public_ip_address = false
  

  tags = {
    Name = "SecurePrivateEC2"
  }
}
