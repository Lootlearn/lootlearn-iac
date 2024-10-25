variable "region" {
  default     = "ap-southeast-2"
  type        = string
  description = "Primary region for your infrastructure"
}

variable "api_key" {
  description = "API public key"
  type        = string
  sensitive   = true
}
variable "aws_access_id" {
  description = "AWS access key"
  type        = string
  sensitive   = true
}
variable "aws_access_key" {
  description = "AWS secret access key"
  type        = string
  sensitive   = true
}
variable "ssh_public_key_name" {
  default = "lootlearn-server-dev-key"
  type        = string
}
variable "ami_id" {
  description = "ID of the AMI to build"
  default     = "ami-001f2488b35ca8aad"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
  type        = string
}
variable "ap-southeast-2a" {
  default = "ap-southeast-2a"
  description = "CPU Amount AWS EC2 instance."
}
variable "ap-southeast-2b" {
  default = "ap-southeast-2b"
  description = "AWS ECS Cluster holding the Container bot file compiler"
}
