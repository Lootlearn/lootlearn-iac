resource "random_id" "rand" {
  byte_length = 8
}
resource "random_string" "rand" {
  length  = 4
}

resource "aws_vpc" "loot_learn_vpc"{
  cidr_block = var.vpc-cidr
}
resource "aws_subnet" "loot_learn_public_subnet_1" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2a
  cidr_block = var.public_vpc_cidr_1
  tags = {
    Name = "Public Subnet 1"
  }
}
resource "aws_subnet" "loot_learn_public_subnet_2" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2b
  cidr_block = var.public_vpc_cidr_2
  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "loot_learn_private_subnet_1" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2a
  cidr_block = var.private_cidr_1
  tags = {
    Name = "Private Subnet 1"
  }
}
resource "aws_subnet" "loot_learn_private_subnet_2" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2b
  cidr_block = var.private_cidr_2
  tags = {
    Name = "Private Subnet 2"
  }
}