output "ndo_vpc_id" {
  description = "VPC id"
  value       = aws_vpc.terraformVPC.id
}

output "ndo_subnet_b" {
  description = "Subnet id for Subnet B"
  value       = aws_subnet.terraformPublicSubnetB.id
}

output "ndo_subnet_c" {
  description = "Subnet id for Subnet C"
  value       = aws_subnet.terraformPublicSubnetC.id
}