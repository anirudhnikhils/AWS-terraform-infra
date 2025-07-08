# ---------------------------------------------
# VPC CIDR block
# ---------------------------------------------
variable "vpc_cidr" {
  description = "VPC CIDR block"
}

# ---------------------------------------------
# Public Subnet CIDRs
# ---------------------------------------------
variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

# ---------------------------------------------
# Private Subnet CIDRs
# ---------------------------------------------
variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

# ---------------------------------------------
# Availability Zones list
# ---------------------------------------------
variable "azs" {
  description = "Availability Zones"
  type        = list(string)
}

# ---------------------------------------------
# Environment name for tagging
# ---------------------------------------------
variable "env_name" {
  description = "Environment name for tagging"
}
