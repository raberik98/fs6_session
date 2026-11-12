module "vpc" {
  source = "./modules/vpc"

  name       = var.vpc.name
  cidr_block = var.vpc.cidr_block
  tags       = var.vpc.tags
  NAT_subnet = var.vpc.NAT_subnet

  subnets = var.vpc.subnets
}


module "keys" {
  source = "./modules/keys"
  for_each = { for key in var.keys : key.name => key.key_string }

  name = each.key
  key_string = each.value
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id = module.vpc.vpc_id
  instances = [
    for ec2 in var.ec2_instances:
      {
        name = ec2.name
        type = ec2.type
        key_name = module.keys[ec2.key_name].key.key_name
        subnet_id = module.vpc.all_subnets[ec2.subnet_name].id
      }
  ]
}