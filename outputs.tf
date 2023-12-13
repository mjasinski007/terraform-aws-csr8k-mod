output "vpc_id" {
  value = aws_vpc.this
}

output "public_subnets" {
  value = aws_subnet.gig1_public_subnet
}

output "private_subnets" {
  value = aws_subnet.gig2_private_subnet
}


output "gig1_eip" {
  value = aws_eip.eip
}