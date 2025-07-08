resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.cluster_iam_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_public_access = true
    endpoint_private_access = true
    security_group_ids = var.node_security_group_ids
  }

  # Optional tags
  tags = {
    Environment = var.cluster_name
  }
}

resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = var.node_iam_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_count
    max_size     = var.node_count + 1
    min_size     = var.node_count
  }

  instance_types = [var.node_instance_type]

  capacity_type = var.capacity_type 

  tags = {
    Name = "${var.cluster_name}-nodes"
  }
}
