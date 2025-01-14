module "network_module" {
  source = "./network_module"
}
resource "random_id" "rand" {
  byte_length = 8
}

# Define the EBS volume
resource "aws_ebs_volume" "ebs_block" {
  availability_zone = var.ap-southeast-2a
  size              = 30
  type              = "gp2"
  tags = {
    Name = "media_volume-${random_id.rand.hex}"
  }
}

# Attach the EBS volume to the EC2 instance
resource "aws_volume_attachment" "volume_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.ebs_block.id
  instance_id = aws_instance.loot-learn-media-server.id
  force_detach = true
}

resource "aws_instance" "loot-learn-media-server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.ssh_public_key_name
  vpc_security_group_ids = [module.network_module.security_group_id]
  associate_public_ip_address = true
  availability_zone = var.ap-southeast-2a
  subnet_id = module.network_module.subnet_id_public_1
  tags = {
    Name = "media_server-${random_id.rand.hex}"
  }
}