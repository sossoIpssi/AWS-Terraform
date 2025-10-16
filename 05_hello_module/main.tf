provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone  = var.availability_zone
  vpc_name = "my-vpc"
}

module "ec2" {
  source            = "./ec2"
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.groupe_securite_id
  key_name          = var.key_name
  instance_name = "web"
}

