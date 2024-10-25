module "network_module" {
  source = "./network_module"
}
resource "random_id" "rand" {
  byte_length = 8
}
resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = var.ap-southeast-2a
  size              = 30
  type              = "gp3"
  tags = {
    Name = "LootlearnStorage-${random_id.rand.hex}"
  }
}
resource "aws_instance" "loot-learn-media-server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.ssh_public_key
  security_groups = [module.network_module.loot-learn-sg_id]
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_id = aws_ebs_volume.ebs_volume.id
    encrypted   = true
    delete_on_termination = true
  }
  volume_tags = {
    Name = format("test_boot-learn-media-server%s", terraform.workspace)
  }
  associate_public_ip_address = true
  availability_zone = var.ap-southeast-2a
}