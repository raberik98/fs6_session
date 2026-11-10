module "vpc" {
  source = "./modules/vpc"

  name       = var.vpc.name
  cidr_block = var.vpc.cidr_block
  tags       = var.vpc.tags

  subnets = var.vpc.subnets
}
