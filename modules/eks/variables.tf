variable "cluster_name" {}
variable "cluster_iam_role_arn" {}
variable "node_iam_role_arn" {}
variable "subnet_ids" { type = list(string) }
variable "node_count" { default = 1 }
variable "node_instance_type" { default = "t3.small" }
variable "capacity_type" { default = "ON_DEMAND" } # or "SPOT"
variable "node_security_group_ids" { type = list(string) }
