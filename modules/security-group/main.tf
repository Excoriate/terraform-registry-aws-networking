resource "aws_security_group" "this" {
  for_each    = local.sg_groups_to_create
  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = local.is_vpc_lookup_enabled ? local.vpc_looked_up : each.value["vpc_id"]

  tags = var.tags
}

resource "aws_security_group_rule" "cidr_based_rule" {
  for_each          = { for k, v in local.sg_group_rules_to_create_cidr_based : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  ipv6_cidr_blocks  = each.value["ipv6_cidr_blocks"]
  prefix_list_ids   = each.value["prefix_list_ids"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "source_sg_based_rule" {
  for_each                 = { for k, v in local.sg_group_rules_to_create_source_sg_based : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  source_security_group_id = aws_security_group.this[each.value["source_sg_name"]].id
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "self_rule" {
  for_each          = { for k, v in local.sg_group_rules_to_create_to_create_self_based : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  self              = true
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}
