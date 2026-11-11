locals {
  subnets         = { for sn in var.subnets : sn.name => sn }
  private_subnets = { for sn in var.subnets : sn.name => sn if sn.type == "private" }
  public_subnets  = { for sn in var.subnets : sn.name => sn if sn.type == "public" }
}

resource "aws_vpc" "this" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = merge({
    Name = var.name
  }, var.tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_eip" "this" {
  domain   = "vpc"

  tags = {
    Name = "${var.name}-nat-eip"
  }
}

#  aws_nat_gateway.this =  [ {} ]
resource "aws_nat_gateway" "this" {
  count = var.NAT_subnet != "" ? 1 : 0

  subnet_id = aws_subnet.public[var.NAT_subnet].id
  allocation_id = aws_eip.this.id
}

#  aws_nat_gateway.this =  { key = {} }
resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = merge({
    Name = "${var.name}-${each.key}"
  }, each.value.tags)
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = false

  tags = merge({
    Name = "${var.name}-${each.key}"
  }, each.value.tags)
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  
  route_table_id = aws_route_table.public.id
  subnet_id = each.value.id
}

resource "aws_route_table_association" "private" {
  for_each = var.NAT_subnet != "" ? aws_subnet.private : {}
  
  route_table_id = aws_route_table.private[0].id
  subnet_id = each.value.id
}