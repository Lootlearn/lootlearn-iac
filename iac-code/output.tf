output "ec2_instance_public_ip" {
  value = aws_instance.loot-learn-media-server.public_ip
}
output "test_server" {
  value = aws_instance.loot-learn-test-server.public_ip
}
# Exporting VPC and Instance IDs
output "loot-learn-sg_id" {
  value = module.network_module.security_group_id
}