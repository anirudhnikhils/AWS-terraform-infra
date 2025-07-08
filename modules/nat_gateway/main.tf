# ---------------------------------------------
# Allocate Elastic IP for NAT Gateway
# ---------------------------------------------
resource "aws_eip" "this" {
  domain = "vpc"
  tags = {
    Name = "${var.env_name}-nat-eip"
  }
}

# ---------------------------------------------
# NAT Gateway in public subnet
# ---------------------------------------------
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.env_name}-nat"
  }
}

# ---------------------------------------------
# Private Route Table for associated private subnets
# ---------------------------------------------
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.env_name}-private-rt"
  }
}

# ---------------------------------------------
# Add route to NAT Gateway
# ---------------------------------------------
resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

# ---------------------------------------------
# Associate private subnets with this private route table
# ---------------------------------------------
resource "aws_route_table_association" "private_assoc" {
  count          = length(var.private_subnet_ids)
  subnet_id      = element(var.private_subnet_ids, count.index)
  route_table_id = aws_route_table.private.id
}
