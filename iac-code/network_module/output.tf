output "security_group_id" {
  value = aws_security_group.loot-learn-sg.id
}
output "subnet_id_public_1" {
  value = aws_subnet.loot_learn_public_subnet_1.id
}