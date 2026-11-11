output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}

output "all_subnets" {
  value = merge(aws_subnet.private, aws_subnet.public)
}