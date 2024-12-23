module "vpc" {
  source = "cloudposse/vpc/aws"
  version     = "2.2.0"
  namespace = "envoy-associates"
  stage     = "prod"
  name      = "smb"

  ipv4_primary_cidr_block = "10.1.0.0/24"

  assign_generated_ipv6_cidr_block = false
}

module "dynamic_subnets" {
  source = "cloudposse/dynamic-subnets/aws"
  version     = "2.4.2"
  namespace          = "envoy-associates"
  stage              = "prod"
  name               = "smb"
  availability_zones = ["eu-west-2a","eu-west-2b","eu-west-2c"]
  nat_gateway_enabled  = false
  vpc_id             = module.vpc.vpc_id
  igw_id             = [module.vpc.igw_id]
}
