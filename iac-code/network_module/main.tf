resource "random_id" "servers" {
  byte_length = 8
  keepers = {
    var.ami_id
  }
}