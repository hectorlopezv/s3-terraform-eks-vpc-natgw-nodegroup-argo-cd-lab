variable "eks_cluster_name" {
    description = "value of the EKS cluster name"
    type        = string
}
variable "node_group_arn" {
    description = "value of the EKS node group ARN"
    type        = string
}
variable "pri_sub_3_id" {
    description = "value of the private subnet 3 ID"
    type        = string
}

variable "pri_sub_4_id" {
    description = "value of the private subnet 4 ID"
    type        = string
}