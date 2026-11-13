# Type = "public"
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.name}-rt-public"
  }
}
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  route_table_id = aws_route_table.public.id
  subnet_id      = each.value.id
}

# Type = "private"
resource "aws_route_table" "private" {
  count = var.NAT_subnet != "" ? 1 : 0

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[0].id
  }

  tags = {
    Name = "${var.name}-rt-private"
  }
}
resource "aws_route_table_association" "private" {
  for_each = var.NAT_subnet != "" ? aws_subnet.private : {}

  route_table_id = aws_route_table.private[0].id
  subnet_id      = each.value.id
}
