output "instances" {
  value = [
    for ec2 in local.instances:
    {
      ec2 = aws_instance.this[ec2.name]
      key_name = ec2.key_name
    }
  ]
}