variable "vpc_name" {
  default = "loot_learn_aci-vpc"
}
variable "vpc-cidr" {
  default = "10.0.0.0/16"
  type = string
  description = "Specify a default VPC"
}
variable "public_vpc_cidr_1" {
  default = "10.0.1.0/24"
  description = "Public VPC cidr 2"
  type = string
}
variable "public_vpc_cidr_2" {
  default = "10.0.2.0/24"
  description = "Public VPC cidr 1"
  type = string
}

variable "private_cidr_1" {
  default = "10.0.100.0/24"
  description = "Private subnet cidr"
  type = string
}
variable "private_cidr_2" {
  default = "10.0.200.0/24"
  description = "Private subnet cidr"
  type = string
}
variable "availability_zone_1" {
  default = "ap-southeast-2"
  type = string
}
variable "availability_zone_2" {
  default = "ap-southeast-2b"
  type = string
}
