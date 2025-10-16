output "vpc_id" {
  value = aws_vpc.mon_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "groupe_securite_id" {
  value = aws_security_group.groupe_securite_web.id
}
