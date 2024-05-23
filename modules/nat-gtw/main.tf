#allocate elastic IP for the natgateway in the public subnet 1 

resource "aws_eip" "EIP-NAT-GW1" {
    domain = "vpc"
    tags = {
        Name = "NAT-GW-EIP1"
    }
}

# allocate elastic ip for the natgateway in the public subnet 2
resource "aws_eip" "EI-NAT-GW2" {
    domain = "vpc"
    tags = {
        Name = "NAT-GW-EIP2"
    }  
}

# create a nat gateway in the public subnet 1
resource "aws_nat_gateway" "nat_gtw1" {
  allocation_id = aws_eip.EIP-NAT-GW1.id
  subnet_id = var.pub_sub1_id
  tags = {
    Name  = "nat_gtw1"
  }
  ## to ensure igw is created before nat gateway
  depends_on =  [var.igw_id]
}

# create a nat gateway in the public subnet 2
resource "aws_nat_gateway" "nat_gtw2" {
  allocation_id = aws_eip.EI-NAT-GW2.id
  subnet_id = var.pub_sub2_id
  tags = {
    Name  = "nat_gtw2"
  }
    ## to ensure igw is created before nat gateway
    depends_on =  [var.igw_id]
}


# create a private route table and a route through nat_gtw1
resource "aws_route_table" "pri-rt-a" {
    vpc_id = var.vpc_id
    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gtw1.id
    }
    tags = {
        Name = "pri-rt-a"
    }
}

# allocate  a private subnet pri-sub3 with private route table pri-rt-a
resource "aws_route_table_association" "pri-sub3-with-rt-a" {
    subnet_id = var.pri_sub3_id
    route_table_id = aws_route_table.pri-rt-a.id
}

# create a private route table and a route through nat_gtw2
resource "aws_route_table" "pri-rt-b" {
    vpc_id = var.vpc_id
    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gtw2.id
    }
    tags = {
        Name = "pri-rt-b"
    }
}

# associate pri subnet 2 with private route table pri-rt-b
resource "aws_route_table_association" "pri-sub4-with-rt-a" {
    subnet_id = var.pri_sub4_id
    route_table_id = aws_route_table.pri-rt-b.id
}