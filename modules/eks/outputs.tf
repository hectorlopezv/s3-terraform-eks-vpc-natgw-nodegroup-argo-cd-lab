output "eks_cluster_name" {
    value = aws_eks_cluster.eks_cluster_argo_cd.id
}