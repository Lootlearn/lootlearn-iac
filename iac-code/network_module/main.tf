resource "aws_vpc" "loot_learn_vpc"{
  cidr_block = var.vpc-cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "lootlearn-vpc"
  }
}

resource "aws_internet_gateway" "media-server-internet-gateway" {
  vpc_id = aws_vpc.loot_learn_vpc.id

  tags = {
    Name = "media-server-internet-gateway"
  }
}
resource "aws_subnet" "loot_learn_public_subnet_1" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2a
  cidr_block = var.public_vpc_cidr_1
  map_public_ip_on_launch = true
  tags = {
    Name = "Lootlearn-public-subnet-1"
  }
}

resource "aws_route_table" "media_server_route_table" {
  vpc_id = aws_vpc.loot_learn_vpc.id

  tags = {
    Name = "media-server-route-table"
  }
}
resource "aws_route" "media_server_route" {
  route_table_id         = aws_route_table.media_server_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.media-server-internet-gateway.id
}
resource "aws_route_table_association" "example_route_table_association" {
  subnet_id      = aws_subnet.loot_learn_public_subnet_1.id
  route_table_id = aws_route_table.media_server_route_table.id
}
resource "aws_subnet" "loot_learn_private_subnet_1" {
  vpc_id            = aws_vpc.loot_learn_vpc.id
  availability_zone = var.ap-southeast-2a
  cidr_block = var.private_cidr_1
  tags = {
    Name = "Lootlearn-private-subnet-1"
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
  ingress {
    from_port   = 3300
    to_port     = 3300
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3001
    to_port     = 3001
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

resource "aws_elb" "loot-media-server-loadbalancer" {
  name = "loot-media-server-loadbalancer"
  availability_zones = [var.ap-southeast-2a, var.ap-southeast-2a]
  listener {
    instance_port     = 3004
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }
  listener {
    instance_port     = 3300
    instance_protocol = "TCP"
    lb_port           = 3300
    lb_protocol       = "TCP"
  }
  listener {
    instance_port     = 8081
    instance_protocol = "TCP"
    lb_port           = 80
    lb_protocol       = "TCP"
  }
}
resource "aws_route53_zone" "primary" {
  name = "lootlearn.online"
}
resource "aws_route53_record" "loot-learn-record" {
  name    = "lootlearn.online"
  type    = "A"
  zone_id = aws_route53_zone.primary.zone_id
  alias {
    evaluate_target_health = false
    name                   = aws_elb.loot-media-server-loadbalancer.dns_name
    zone_id                = aws_elb.loot-media-server-loadbalancer.zone_id
  }
}
resource "aws_lb_target_group" "loot-media-server_tg_3004" {
  name     = "loot-media-server-tg"
  port     = 3004
  protocol = "TCP"
  vpc_id   = aws_vpc.loot_learn_vpc.id
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "TCP"
    port                = 3004
  }
}
resource "aws_lb_target_group" "loot-media-server_tg_3300" {
  name     = "loot-media-server-tg"
  port     = 3300
  protocol = "TCP"
  vpc_id   = aws_vpc.loot_learn_vpc.id
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    protocol            = "TCP"
    port                = 3300
  }
}

