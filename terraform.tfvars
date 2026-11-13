aws_region  = "eu-west-1"
aws_profile = "cc-devops-FS6"

vpc = {
  name       = "f6-vpc"
  cidr_block = "10.0.0.0/16"
  tags       = {}
  NAT_subnet = "public_1"

  subnets = [
    {
      name       = "public_1"
      cidr_block = "10.0.0.0/24"
      type       = "public"
      az         = "a"
    },
    {
      name       = "public_2"
      cidr_block = "10.0.1.0/24"
      type       = "public"
      az         = "b"
    },
    {
      name       = "private_1"
      cidr_block = "10.0.2.0/24"
      type       = "private"
      az         = "a"
    },
    {
      name       = "private_2"
      cidr_block = "10.0.3.0/24"
      type       = "private"
      az         = "b"
    },
  ]
}

keys = [
  {
    name       = "example"
    key_path   = "keys/example.pub"
  }
]

ec2_instances = [
  {
    name        = "ec2.1"
    type        = ""
    key_name    = "example"
    subnet_name = "public_1"
  }
]
