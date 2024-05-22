resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    assign_generated_ipv6_cidr_block = true

    tags = {
        Name = "${var.project_name}-vpc-argocd-eks"
    }
}

#Create IGW and attach to the above vpc
resource "aws_internet_gateway" "igw-argocd-eks" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "${var.project_name}-igw-argocd-eks"
    }
}

# set data source to get availability AZS in the region us-east-1
data "aws_availability_zones" "availability_zone" {  }

# Now we create the subnets

#First the public
resource "aws_subnet" "pub_sub1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub1_cidr
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.availability_zone.names[0]

    tags = {
        Name = "pub-sub1-argocd-eks"
        "kubernetes.io/cluster/${var.project_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
    }
}

#create second public subnet 2

resource "aws_subnet" "pub_sub2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub_sub2_cidr
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.availability_zone.names[1]
    tags = {
        Name = "pub-sub2-argocd-eks"
        "kubernetes.io/cluster/${var.project_name}" = "shared"
        "kubernetes.io/role/elb" = "1"
    }
}

# create a public Route  TABLE and a route for the route table for public subnets

resource "aws_route_table" "pub_rt" {
    vpc_id = aws_vpc.vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-argocd-eks.id
    }

    tags = {
        Name = "${var.project_name}-pub-rt-argocd-eks"
    }
}

# Associate the public route table with the public subnets
resource "aws_route_table_association" "pub_rt_a" {
    subnet_id = aws_subnet.pub_sub1.id
    route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "pub_rt_b" {
    subnet_id = aws_subnet.pub_sub2.id
    route_table_id = aws_route_table.pub_rt.id
}

# Now we create the private subnets

resource "aws_subnet" "pri_sub3" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub3_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[0]

    tags = {
        Name = "pri-sub3-argocd-eks"
        "kubernetes.io/cluster/${var.project_name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
    }
}

resource "aws_subnet" "pri_sub4" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pri_sub4_cidr
    availability_zone = data.aws_availability_zones.availability_zone.names[1]

    tags = {
        Name = "pri-sub4-argocd-eks"
        "kubernetes.io/cluster/${var.project_name}" = "shared"
        "kubernetes.io/role/internal-elb" = "1"
    }
}