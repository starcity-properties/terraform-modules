######
# VPC
######
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "vpc-${var.environment}"
  }
}

#################
# Public Subnets
#################
resource "aws_subnet" "public-subnet" {
  count             = "${length(var.public_subnets)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(concat(var.public_subnets, list("")), count.index)}"
  availability_zone = "${element(concat(var.availability_zones, list("")), count.index)}"

  tags = {
    Name        = "public-subnet-${var.environment}"
    Environment = "${var.environment}"
  }
}

##################
# Private Subnets
##################
resource "aws_subnet" "private-subnet" {
  count             = "${length(var.private_subnets)}"
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(concat(var.private_subnets, list("")), count.index)}"
  availability_zone = "${element(concat(var.availability_zones, list("")), count.index)}"

  tags = {
    Name        = "private-subnet-${var.environment}"
    Environment = "${var.environment}"
  }
}

##########
# Routes
##########
resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "private-route-${var.environment}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "public-route-${var.environment}"
  }
}

###################
# Internet Gateway
###################
resource "aws_internet_gateway" "ig" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
    Name        = "ig-${var.environment}"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "ig-public-route" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.ig.id}"
}

##############
# NAT Gateway
##############
resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "ng" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${element(aws_subnet.public-subnet.*.id, 0)}"

  tags {
    Name = "ng-${var.environment}"
  }
}

resource "aws_route" "nat-private-route" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.ng.id}"
}

##########################
# Route Table Association
##########################
resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}
