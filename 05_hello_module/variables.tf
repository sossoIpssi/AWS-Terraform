variable "region" { default = "us-east-1" }
variable "vpc_cidr" { default = "10.0.0.0/16" }
variable "public_subnet_cidr" { default = "10.0.1.0/24" }
variable "private_subnet_cidr" { default = "10.0.2.0/24" }
variable "availability_zone" { default = "us-east-1a" }
variable "ami" { default = "ami-0360c520857e3138f" }
variable "instance_type" { default = "t2.micro" }
variable "key_name" { default = "web_apache_key" }
