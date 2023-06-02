#####################
# VPC Module 
####################
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      Name = format("%s-vpc", var.name)
    },
    var.tags,
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = format("%s-ig", var.name)
    },
    var.tags,
  )
}

resource "aws_eip" "this" {
  count      = length(var.vpc_public_subents)
  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  count         = length(var.vpc_private_subents)
  allocation_id = element(aws_eip.this.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = merge(
    {
      Name = format("%s-nat-gw", var.name)
    },
    var.tags,
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]
}


#####################
# Public Subents
####################

resource "aws_subnet" "public" {
  count             = length(var.vpc_public_subents)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_public_subents[count.index]
  availability_zone = element(var.azs, count.index)

  tags = merge(
    {
      Name = format("%s-public-%s-subnet", var.name, element(var.azs, count.index))
    },
    var.tags,
    var.public_subnets_tags,
  )

}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  count  = length(var.vpc_public_subents)
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.name}-public-route-table"
    },
    var.tags,
  )
}

resource "aws_route" "public_internet_gateway" {
  count                  = length(var.vpc_public_subents)
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}


/* Route table associations */
resource "aws_route_table_association" "public" {
  count          = length(var.vpc_public_subents)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

#####################
# Private Subents
####################

resource "aws_subnet" "private" {
  count             = length(var.vpc_private_subents)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_private_subents[count.index]
  availability_zone = element(var.azs, count.index)



  tags = merge(
    {
      Name = format("%s-private-%s-subnet", var.name, element(var.azs, count.index))
    },
    var.tags,
    var.private_subnets_tags
  )
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  count  = length(var.vpc_private_subents)
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.name}-private-route-table"

    },
    var.tags,
  )
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.vpc_private_subents)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(var.vpc_private_subents)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}