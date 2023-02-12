resource "aws_security_group" "this" {
  for_each    = local.sg_groups_to_create
  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = local.is_vpc_lookup_enabled ? local.vpc_looked_up : each.value["vpc_id"]

  tags = var.tags
}
