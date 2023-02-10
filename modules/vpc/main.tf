resource "aws_vpc" "this" {
  count                = local.enable_creation
  cidr_block           = var.vpc_config.cidr_block
  instance_tenancy     = var.vpc_config.instance_tenancy
  enable_dns_hostnames = var.vpc_config.enable_dns_hostnames
  enable_dns_support   = var.vpc_config.enable_dns_support
  tags                 = var.tags
}

resource "aws_security_group" "tis" {
  count       = local.enable_creation
  name        = format("%s-vpc-sg", local.vpc_id)
  description = "Default security group of vpc ${local.vpc_id}-${local.vpc_id} to allow inbound/outbound from the VPC"
  vpc_id      = local.vpc_id
  tags        = var.tags

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = -1
    self      = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
