# ---------------------------------------------
# Output VPC ID - baaki modules me use karoge
# ---------------------------------------------
output "vpc_id" {
  value = aws_vpc.this.id
}

# ---------------------------------------------
# Output Public Subnet IDs
# ---------------------------------------------
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

# ---------------------------------------------
# Output Private Subnet IDs
# ---------------------------------------------
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

