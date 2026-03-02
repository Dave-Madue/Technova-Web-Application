variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "technova-dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "public_subnet_cidr_1" {
  type    = string
  default = "10.20.1.0/24"
}

variable "public_subnet_cidr_2" {
  type    = string
  default = "10.20.3.0/24"
}

variable "private_subnet_cidr_1" {
  type    = string
  default = "10.20.2.0/24"
}

variable "private_subnet_cidr_2" {
  type    = string
  default = "10.20.4.0/24"
}

variable "instance_type" {
  type    = string
  default = "t3.micro" # free tier-ish eligible depending on account
}

variable "db_name" {
  type    = string
  default = "technovadb"
}

variable "db_username" {
  type    = string
  default = "technova"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "my_ip_cidr" {
  type        = string
  description = "Your public IP in CIDR format, e.g. 102.89.12.34/32"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/technova.pub"
}