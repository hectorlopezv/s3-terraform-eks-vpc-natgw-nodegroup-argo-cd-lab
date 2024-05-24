output "eks_role_name" {
    value = aws_iam_role.eks_cluster_iam_role.name
}

output "eks_role_node_group_name" {
    value = aws_iam_role.node_group_role.name
}

output "eks_cluster_role_arn" {
    value = aws_iam_role.eks_cluster_iam_role.arn
}

output "eks_node_group_role_arn" {
    value = aws_iam_role.node_group_role.arn
}