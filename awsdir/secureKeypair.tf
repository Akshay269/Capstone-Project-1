# 1. Create a Security Group
resource "aws_security_group" "web_sg" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.main.id


  # Inbound SSH (Port 22) from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTP (Port 80) from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules (Allow all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# 2. Generate an EC2 Key Pair
# This looks for a public key file you've already created on your EC2/Local machine
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_ed25519.pub") # Path to your public key
}




