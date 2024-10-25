resource "random_id" "rand" {
  byte_length = 8
}


resource "aws_vpc" "loot_learn_vpc"{
  cidr_block = var.vpc-cidr
  tags = {
    Name = "lootlearn-${random_id.rand.hex}"
  }
}
resource "aws_subnet" "loot_learn_public_subnet_1" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2a
  cidr_block = var.public_vpc_cidr_1
  tags = {
    Name = "Public-Subnet-${random_id.rand.hex}"
  }
}
resource "aws_subnet" "loot_learn_public_subnet_2" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2b
  cidr_block = var.public_vpc_cidr_2
  tags = {
    Name = "Public-Subnet-${random_id.rand.hex}"
  }
}

resource "aws_subnet" "loot_learn_private_subnet_1" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2a
  cidr_block = var.private_cidr_1
  tags = {
    Name = "Private-Subnet-${random_id.rand.hex}"
  }
}
resource "aws_subnet" "loot_learn_private_subnet_2" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2b
  cidr_block = var.private_cidr_2
  tags = {
    Name = "Private-Subnet-${random_id.rand.hex}"
  }
}

# Security Group for Frontend (Public)
resource "aws_security_group" "loot-learn-sg" {
  name        = "frontend-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = aws_vpc.loot_learn_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3004
    to_port     = 3004
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Exporting VPC and Instance IDs
output "loot-learn-sg_id" {
  value = aws_security_group.loot-learn-sg.id
}

