module "network_module" {
  source = "./network_module"
}
resource "random_id" "rand" {
  byte_length = 8
}
resource "aws_instance" "loot-learn-media-server" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.ssh_public_key
  security_groups = [module.network_module.loot-learn-sg_id]
  ebs_block_device {
    device_name           = "loot_learn_ebs"
    volume_size           = "30"
    volume_type           = "gp2"
    delete_on_termination = true
  }
  associate_public_ip_address = true

}