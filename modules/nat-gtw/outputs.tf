output "aws_eip_EIP_NAT_GW1" {
    value = aws_eip.EIP-NAT-GW1.allocation_id
}
output "aws_eip_EIP_NAT_GW2" {
    value =  aws_eip.EI-NAT-GW2.allocation_id
}
output "nat_gtw1_id" {
    value = aws_nat_gateway.nat_gtw1.id
}
output "nat_gtw2_id" {
    value = aws_nat_gateway.nat_gtw2.id
}

