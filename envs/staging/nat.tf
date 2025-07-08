# Single NAT Gateway for staging (cost saving)
module "nat_gateway" {
  source              = "../../modules/nat_gateway"
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = element(module.vpc.public_subnet_ids, 0)
  private_subnet_ids  = module.vpc.private_subnet_ids
  env_name            = var.env_name
}