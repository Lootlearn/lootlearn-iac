output "ec2_instance_public_ip" {
  value = aws_instance.loot-learn-media-server.public_ip
}