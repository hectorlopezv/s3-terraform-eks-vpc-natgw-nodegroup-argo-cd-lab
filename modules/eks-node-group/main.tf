resource "aws_eks_node_group" "eks_node_group_argo_cd" {
    cluster_name = var.eks_cluster_name

        # name of the eks node group
         node_group_name = "${var.eks_cluster_name}-node-group"

     # aws roles for the eks node gruoup
     node_role_arn = var.node_group_arn

    # the subnets used by the eks node group ec2 instances
      # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/EKS_CLUSTER_NAME 

     subnet_ids = [
        var.pri_sub_3_id,
        var.pri_sub_4_id
     ]


     #configuration block for the scaling configuration of the eks node group
     scaling_config {
       # required number of worker nodes
         desired_size = 1

         # maxium number of worker nodes
         max_size = 2
         #minimum number of worker nodes
         min_size = 1
     }

     #Type of instance to launch for the worker nodes
    // ami type amazon machine linux 2023
    ami_type = "AL2_x86_64"

    # type of capacity for the instance to launch for the worker nodes
    capacity_type = "ON_DEMAND"

    # Disk size in GB for worker nodes
    disk_size = 20

    # Force version update if existing pods are unable to be drained due to a pod disruption budget issue
    force_update_version = false

    # The instance types to use for the worker nodes
    instance_types = ["t3.small"]

    labels = {
      role = "${var.eks_cluster_name}-Node_group_role"
      name = "${var.eks_cluster_name}-Node_group"
    }

    # kubernets version
    version = "1.29"

}