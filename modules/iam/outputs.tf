output "eks_role" {
    value = aws_iam_role.eks_cluster_iam_role.name
}

output "eks_role_node_group" {
    value = aws_iam_role.node_group_role.name
}