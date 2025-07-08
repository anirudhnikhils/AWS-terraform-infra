output "cluster_name" {
  value = aws_eks_cluster.this.name
}
output "nodegroup_name" {
  value = aws_eks_node_group.this.node_group_name
}
