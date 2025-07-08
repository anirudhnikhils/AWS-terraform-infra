# ---------------------------------------------------------
# Create VPC
# ---------------------------------------------------------
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr    
  enable_dns_hostnames = true            
  tags = {
    Name = "${var.env_name}-vpc"          
  }
}

# ---------------------------------------------------------
# Internet Gateway - 
# ---------------------------------------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id               # Is VPC ka IGW ban raha hai
  tags = {
    Name = "${var.env_name}-igw"
  }
}

# ---------------------------------------------------------
# Public Subnet 
# ---------------------------------------------------------
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)  # Kitne public subnets banana hai
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)    # AZ ka bhi variable use kar rahe hain
  map_public_ip_on_launch = true                              # EC2 launch pe public IP milegi

  tags = {
    Name = "${var.env_name}-public-${count.index + 1}"
  }
}

# ---------------------------------------------------------
# Private Subnet 
# ---------------------------------------------------------
resource "aws_subnet" "private" {
  count                   = length(var.private_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.private_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name = "${var.env_name}-private-${count.index + 1}"
  }
}

# ---------------------------------------------------------
# Public Route Table + IGW route
# ---------------------------------------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.env_name}-public-rt"
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"    # Internet ke liye default route
  gateway_id             = aws_internet_gateway.this.id
}

# ---------------------------------------------------------
# Associate Public Subnets to Public Route Table
# ---------------------------------------------------------
resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
