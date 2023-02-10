locals {
  aws_region_to_deploy = var.aws_region
  is_vpc_enabled       = var.is_enabled && var.vpc_config != null
  enable_creation      = local.is_vpc_enabled ? 1 : 0

  /*
  * VPC configuration
  */
  vpc_id = join("", [for v in aws_vpc.this : v.id])

  /*
    * Subnet configuration
  */
  is_subnets_enabled       = local.is_vpc_enabled && var.subnet_config != null
  availability_zones       = !local.is_subnets_enabled ? [] : data.aws_availability_zones.available.names
  availability_zones_limit = !local.is_subnets_enabled ? 0 : var.subnet_config.availability_zones_limit
  availability_zones_names = !local.is_subnets_enabled ? [] : slice(local.availability_zones, 0, var.subnet_config.availability_zones_limit)

  /*
    * CIDR
  */
  cidr_block = trimspace(var.vpc_config.cidr_block)
  private_subnets_cidr_list = !local.is_vpc_enabled ? [] : [
    for index, value in local.availability_zones_names : cidrsubnet(local.cidr_block, 4, index)
  ]
  public_subnets_cidr_list = !local.is_vpc_enabled ? [] : [
    for index, value in local.availability_zones_names : cidrsubnet(local.cidr_block, 4, (index + local.availability_zones_limit))
  ]
}
