variable "vpc_id" {
  description = "VPC ID"
}

variable "public_subnet_id" {
  description = "Public Subnet ID where NAT Gateway will be created"
}

variable "private_subnet_ids" {
  description = "List of Private Subnet IDs to route via NAT Gateway"
  type        = list(string)
}

variable "env_name" {
  description = "Environment name for tagging"
}
