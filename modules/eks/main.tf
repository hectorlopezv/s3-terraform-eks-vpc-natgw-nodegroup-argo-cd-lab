resource "aws_eks_cluster" "eks_cluster_argo_cd" {
    name = "${var.project_name}-eks-cluster-argocd"
    role_arn = var.eks_cluster_role_Arn
    version = "1.29"
    vpc_config {
        endpoint_private_access = false
        endpoint_public_access = true
        subnet_ids = [
        var.pub_sub1_id,
        var.pub_sub2_id,
        var.pri_sub_3_id,
        var.pri_sub_4_id
        ]
    }
}