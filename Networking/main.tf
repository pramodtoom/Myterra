resource "aws_vpc" "VPC" {
  cidr_block = "${var.cidr}.0.0/16"
  tags = "${
    map(
      "Name", "${var.cluster-name}.vpc",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_subnet" "public_subnet" {
  count = "${var.vpc-subnets-count}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id = "${aws_vpc.VPC.id}"
  cidr_block = "${var.cidr}.${count.index}.0/24"
  tags = "${
    map(
      "Name", "${var.cluster-name}.publicsubnet.${count.index}",
      "kubernetes.io/cluster/${var.cluster-name}", "shared",
    )
  }"
}

resource "aws_internet_gateway" "IGW" {
    vpc_id = "${aws_vpc.VPC.id}" 

    tags = {
    Name = "${var.cluster-name}.IGW"
    }
}

resource "aws_route_table" "Public_route" {
    vpc_id = "${aws_vpc.VPC.id}" 
    
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.IGW.id}"
    }

    tags = {
    Name = "${var.cluster-name}.Public_route"
    }
}

resource "aws_route_table_association" "publicsubnetRT" {
    count          = "${var.vpc-subnets-count}"
    subnet_id = "${aws_subnet.public_subnet.*.id[count.index]}"
    route_table_id = "${aws_route_table.Public_route.id}"
}


