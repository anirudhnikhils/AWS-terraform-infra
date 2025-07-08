# NAT Gateway per AZ for High Availability
module "nat_gateway" {
  count               = length(module.vpc.public_subnet_ids)
  source              = "../../modules/nat_gateway"
  vpc_id              = module.vpc.vpc_id
  public_subnet_id    = element(module.vpc.public_subnet_ids, count.index)
  private_subnet_ids  = [element(module.vpc.private_subnet_ids, count.index)]
  env_name            = var.env_name
}