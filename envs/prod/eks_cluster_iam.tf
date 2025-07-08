# ---------------------------------------------
# EKS Control Plane IAM Role
# ---------------------------------------------
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.env_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach required EKS policies
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

# Output the IAM role ARN
output "eks_cluster_role_arn" {
  description = "IAM role ARN for EKS control plane"
  value       = aws_iam_role.eks_cluster_role.arn
}
