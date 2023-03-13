/*
 * These are OOO set of rules, that are enabled by the feature flags included in the 'var.security_group_rules_ooo' configuration.
 * Rules: HTTP, HTTPS, ICMP, SSH, RDP, PosgreSQL, and MySQ
*/
resource "aws_security_group_rule" "ooo_inbound_all_traffic" {
  for_each          = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_inbound_all_traffic"] && !v["is_source_sg_enabled"] }
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "ooo_inbound_all_traffic_from_sg" {
  for_each                 = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_inbound_all_traffic_from_sg"] && v["is_source_sg_enabled"] }
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_all_traffic" {
  for_each          = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_outbound_all_traffic"] && !v["is_source_sg_enabled"] }
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "ooo_outbound_all_traffic_to_sg" {
  for_each                 = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_outbound_all_traffic_to_sg"] && v["is_source_sg_enabled"] }
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}
