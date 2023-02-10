resource "aws_subnet" "private" {
  count = length(local.availability_zones_names)

  vpc_id                  = local.vpc_id
  cidr_block              = local.private_subnets_cidr_list[count.index]
  availability_zone       = local.availability_zones_names[count.index]
  map_public_ip_on_launch = var.subnet_config.map_public_ip_on_launch_subnet_private
}

resource "aws_subnet" "public" {
  count = length(local.availability_zones_names)

  vpc_id                  = local.vpc_id
  cidr_block              = local.public_subnets_cidr_list[count.index]
  availability_zone       = local.availability_zones_names[count.index]
  map_public_ip_on_launch = var.subnet_config.map_public_ip_on_launch_subnet_public
}
