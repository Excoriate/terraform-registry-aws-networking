resource "aws_security_group_rule" "custom_cidr_based" {
  for_each          = { for k, v in local.sg_rules_custom_create : k => v if !v["is_source_sg_enabled"] }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  ipv6_cidr_blocks  = each.value["ipv6_cidr_blocks"]
  prefix_list_ids   = each.value["prefix_list_ids"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "custom_sg_based" {
  for_each                 = { for k, v in local.sg_rules_custom_create : k => v if v["is_source_sg_enabled"] }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  prefix_list_ids          = each.value["prefix_list_ids"]
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}
