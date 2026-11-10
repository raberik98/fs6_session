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
