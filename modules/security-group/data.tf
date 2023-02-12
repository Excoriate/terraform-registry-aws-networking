data "aws_vpc" "default" {
  count   = !local.is_vpc_default_lookup_enabled ? 0 : 1
  default = true
}

data "aws_vpc" "named" {
  count = local.is_vpc_named_lookup_enabled ? 1 : 0
  tags = {
    Name = local.vpc_lookup_name
  }
}
