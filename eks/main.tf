##################
#   Target VPC   #
##################
module "vpc_target" {
  source  = "cloudposse/vpc/aws"
  version = "0.28.1"

  cidr_block = var.target_cidr_block
}

#################################
#   Target Subnets in all AZs   #
#################################
module "subnets" {
  source  = "cloudposse/dynamic-subnets/aws"
  version = "0.39.8"

  name = "vpc-subnets"

  availability_zones = var.availability_zones
  vpc_id             = module.vpc_target.vpc_id
  igw_id             = module.vpc_target.igw_id
  cidr_block         = module.vpc_target.vpc_cidr_block

  nat_gateway_enabled  = true
  nat_instance_enabled = false
}