output "security_group_id" {
  value = aws_security_group.loot-learn-sg.id
}
output "subnet_id_public_1" {
  value = aws_subnet.loot_learn_public_subnet_1.id
}
# output "loot_learn_aws_target_group_3004"{
#   value = aws_lb_target_group.loot-media-server_tg_3004.arn
# }
# output "loot_learn_aws_target_group_3300"{
#   value = aws_lb_target_group.loot-media-server_tg_3300.arn
# }