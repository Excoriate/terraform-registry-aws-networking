resource "aws_security_group_rule" "ooo_inbound_custom_port" {
  for_each          = { for k, v in local.sg_rules_ooo_create : k => v if v["is_custom_port_enabled"] && !v["is_source_sg_enabled"] }
  type              = "ingress"
  from_port         = each.value["custom_port"]
  to_port           = each.value["custom_port"]
  protocol          = "tcp"
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "ooo_inbound_custom_port_from_sg" {
  for_each                 = { for k, v in local.sg_rules_ooo_create : k => v if v["is_custom_port_enabled"] && v["is_source_sg_enabled"] }
  type                     = "ingress"
  from_port                = each.value["custom_port"]
  to_port                  = each.value["custom_port"]
  protocol                 = "tcp"
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_custom_port" {
  for_each          = { for k, v in local.sg_rules_ooo_create : k => v if v["is_custom_port_enabled"] && !v["is_source_sg_enabled"] }
  type              = "egress"
  from_port         = each.value["custom_port"]
  to_port           = each.value["custom_port"]
  protocol          = "tcp"
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "ooo_outbound_custom_port_to_sg" {
  for_each                 = { for k, v in local.sg_rules_ooo_create : k => v if v["is_custom_port_enabled"] && v["is_source_sg_enabled"] }
  type                     = "egress"
  from_port                = each.value["custom_port"]
  to_port                  = each.value["custom_port"]
  protocol                 = "tcp"
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}
