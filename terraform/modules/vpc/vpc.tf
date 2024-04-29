resource "aws_vpc" "main" {
    cidr_block = var.cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "MainInternetGateway"
    }
}

resource "aws_eip" "ngw" {
    count = 3
    vpc = true
}

resource "aws_subnet" "public" {
    count = 3
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
    tags = {
        Name = "PublicSubnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count = 3
    vpc_id = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = "${var.region}${element(["a", "b", "c"], count.index)}"
    tags = {
        Name = "PrivateSubnet-${count.index + 1}"
    }
}

resource "aws_nat_gateway" "ngw" {
    count = 3
    subnet_id = aws_subnet.public[count.index].id
    allocation_id = aws_eip.ngw[count.index].id
    tags = {
        Name = "MainNATGateway-${count.index + 1}"
    }
}

resource "aws_route_table" "public" {
    count = 3
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
        Name = "PublicRouteTable-${count.index + 1}"
    }
}

resource "aws_route_table_association" "public" {
    count = 3
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public[count.index].id
}

resource "aws_route_table" "private" {
    count = 3
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw[count.index].id
    }
    tags = {
        Name = "PrivateRouteTable-${count.index + 1}"
    }
}

resource "aws_route_table_association" "private" {
    count = 3
    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}