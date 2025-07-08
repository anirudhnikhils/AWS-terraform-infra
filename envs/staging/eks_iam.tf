module "iam" {
  source   = "../../modules/iam"
  env_name = var.env_name
}

module "eks" {
  source                   = "../../modules/eks"
  cluster_name             = "${var.env_name}-eks"
  cluster_iam_role_arn     = aws_iam_role.eks_cluster_role.arn    
  node_iam_role_arn        = module.iam.eks_node_role_arn           
  subnet_ids               = module.vpc.private_subnet_ids
  node_count               = 1
  node_instance_type       = "t3.small"
  capacity_type            = "SPOT"
  node_security_group_ids  = [module.eks_node_sg.security_group_id] 
}
