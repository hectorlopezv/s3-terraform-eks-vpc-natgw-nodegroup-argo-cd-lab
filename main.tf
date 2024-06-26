#Mock t2.micro resource
resource "aws_instance" "app_server_amazon_linux_2023" {

    ami = "ami-0bb84b8ffd87024d8"
    instance_type = var.instance_type
    availability_zone = var.instance_az

    tags = {
      Name = var.instance_name
    }
}

#Magic happens for argoCd, EKS AWS
module "VPC" {
  source = "./modules/vpc"
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  pub_sub1_cidr = var.pub_sub1_cidr
  pub_sub2_cidr = var.pub_sub2_cidr
  pri_sub3_cidr = var.pri_sub3_cidr
  pri_sub4_cidr = var.pri_sub4_cidr
  region = var.region
}

# nat gatweway for prive subnets and elastic ip
module "NAT-GTW"{
  source = "./modules/nat-gtw"
  pub_sub1_id = module.VPC.PUB_SUB1_ID
  pri_sub3_id = module.VPC.PRI_SUB3_ID
  pri_sub4_id = module.VPC.PRI_SUB4_ID
  pub_sub2_id = module.VPC.PUB_SUB2_ID
  igw_id = module.VPC.IGW_ID
  vpc_id = module.VPC.VPC_ID
}

# IAM roles for EKS service
module "IAM"{
  source = "./modules/iam"
  project_name = var.project_name
}

# EKS cluster

module "EKS" {
  source = "./modules/eks"
  project_name = var.project_name
  eks_cluster_role_Arn = module.IAM.eks_cluster_role_arn
  pub_sub1_id = module.VPC.PUB_SUB1_ID
  pub_sub2_id = module.VPC.PUB_SUB2_ID
  pri_sub_3_id = module.VPC.PRI_SUB3_ID
  pri_sub_4_id = module.VPC.PRI_SUB4_ID
  depends_on = [module.VPC, module.IAM]
}

# EKS node group
module "EKS_NODE_GROUP" {
  source = "./modules/eks-node-group"
  eks_cluster_name = module.EKS.eks_cluster_name
  pri_sub_3_id = module.VPC.PRI_SUB3_ID
  pri_sub_4_id = module.VPC.PRI_SUB4_ID
  node_group_arn = module.IAM.eks_node_group_role_arn
}