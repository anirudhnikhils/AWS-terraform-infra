output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

output "nat_eip" {
  value = aws_eip.this.public_ip
}

output "route_table_id" {
  value = aws_route_table.private.id
}
