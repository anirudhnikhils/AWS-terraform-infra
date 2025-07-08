module "eks_node_sg" {
  source = "../../modules/security_group"
  name   = "staging-eks-node-sg"
  vpc_id = module.vpc.vpc_id

  ingress_rules = [
    # ✅ Inter-node communication (pod-to-pod, kubelet)
    {
      description = "Allow node-to-node communication"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      self        = true    
    },

    # ✅ EKS control plane to node (Kubelet)
    {
      description = "Allow control plane to kubelet"
      from_port   = 10250
      to_port     = 10250
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    },

    # ✅ NodePort range 
    {
      description = "Allow NodePort range"
      from_port   = 30000
      to_port     = 32767
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },

    # ✅ Application traffic - HTTP
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },

    # ✅ Application traffic - HTTPS
    {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
