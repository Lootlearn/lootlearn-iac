variable "region" {
  default = "ap-southeast-2"
  type = string
  description = "Primary region for your infrastructure"
}
variable "vpc-cidr" {
  default = "10.0.0.0/16"
  type = string
  description = "Specify a default VPC"
}
variable "public_cidr" {
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
  description = "Public VPC cidr"
  type = list(string)
}
variable "private_cidr" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  description = "Private subnet cidr"
  type = list(any)
}