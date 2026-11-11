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