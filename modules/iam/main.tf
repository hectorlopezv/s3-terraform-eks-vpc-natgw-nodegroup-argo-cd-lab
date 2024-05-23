# lets create a iam role for eks argocd service account

# aws_iam_role.cluster-serviceRole will be created
#esto es para el cluster

# create the policy
data "aws_iam_policy_document" "assume_role_eks" {
  statement {
    effect = "Allow"
    principals {
        type        = "Service"
        identifiers = ["eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
  
}

# create the role and attach the policy
resource "aws_iam_role" "eks_cluster_iam_role" {
    name = "${var.project_name}-EKS-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_eks.json

}


# attach amazon predined policy to the role

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    # The policy should be applied to role
    role = aws_iam_role.eks_cluster_iam_role.name
}

resource "aws_iam_role_policy_attachment" "ELB_Full_Access" {
    policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
    role       = aws_iam_role.eks_cluster_iam_role.name
}

# now lets create iam role for EKS Node Group
#create the policy
data "aws_iam_policy_document" "assume_role_ec2" {
    statement {
        effect = "Allow"
        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_role" "node_group_role" {
    name = "${var.project_name}-node-group-role"
    assume_role_policy = data.aws_iam_policy_document.assume_role_ec2.json
}

# attach this roles to worker nodes

resource "aws_iam_role_policy_attachment" "worker_node" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {

# https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
role       = aws_iam_role.node_group_role.name
}

resource "aws_iam_role_policy_attachment" "ECR_read_only" {

  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node_group_role.name
}