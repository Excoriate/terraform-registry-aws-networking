resource "aws_security_group_rule" "ooo_inbound_all_http" {
  for_each          = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_inbound_all_http"] && !v["is_source_sg_enabled"] }
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "ooo_inbound_all_http_from_sg" {
  for_each                 = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_inbound_all_http_from_sg"] && v["is_source_sg_enabled"] }
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_all_http" {
  for_each          = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_outbound_all_http"] && !v["is_source_sg_enabled"] }
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
}

resource "aws_security_group_rule" "ooo_outbound_all_http_to_sg" {
  for_each                 = { for k, v in local.sg_rules_ooo_create : k => v if v["enable_outbound_all_http_to_sg"] && v["is_source_sg_enabled"] }
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = lookup(local.sg_create, each.key)["lookup_by_id_enabled"] ? data.aws_security_group.sg_by_id[each.key].id : data.aws_security_group.sg_by_name[each.key].id
  source_security_group_id = each.value["source_security_group_id"]
}
