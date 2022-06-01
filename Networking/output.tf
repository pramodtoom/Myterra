#-----networking/outputs.tf----
output "VPC" {
  value = "${aws_vpc.VPC.id}"
}

output "VPC_CIDR" {
  value = "${aws_vpc.VPC.cidr_block}"
}

output "public_subnet" {
  value = "${aws_subnet.public_subnet.*.id}"
}

output "public_subnet_ip" {
  value = "${aws_subnet.public_subnet.*.cidr_block}"
}

output "IGW" {
  value = "${aws_internet_gateway.IGW.id}"
}


output "route_table_id" {
  value = "${aws_route_table.Public_route.id}"
}


