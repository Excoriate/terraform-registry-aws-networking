resource "aws_security_group" "this" {
  for_each    = local.sg_groups_to_create
  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = local.is_vpc_lookup_enabled ? local.vpc_looked_up : each.value["vpc_id"]

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
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
  source_security_group_id = each.value["source_security_group_id"]
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

/*
 * These are OOO set of rules, that are enabled by the feature flags included in the 'var.security_group_rules_ooo' configuration.
 * Rules: HTTP, HTTPS, ICMP, SSH, RDP, PosgreSQL, and MySQ
*/
resource "aws_security_group_rule" "ooo_inbound_all_traffic" {
  for_each          = { for k, v in local.security_group_rules_ooo_inbound_all : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_inbound_all_traffic_from_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_from_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_inbound_http" {
  for_each          = { for k, v in local.security_group_rules_ooo_inbound_http : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_inbound_http_from_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_http_from_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_inbound_https" {
  for_each          = { for k, v in local.security_group_rules_ooo_inbound_https : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_inbound_https_from_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_https_from_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_inbound_icmp_from_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_icmp : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_inbound_icmp_from_anywhere" {
  for_each          = { for k, v in local.security_group_rules_ooo_inbound_icmp_any : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
  cidr_blocks       = each.value["cidr_blocks"]
}

resource "aws_security_group_rule" "ooo_inbound_ssh_from_anywhere" {
  for_each          = { for k, v in local.security_group_rules_ooo_inbound_ssh : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_inbound_rdp_from_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_ssh_from_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_inbound_mysq_from_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_mysql_from_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_all_traffic" {
  for_each          = { for k, v in local.security_group_rules_ooo_outbound_all : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_outbound_all_traffic_to_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_outbound_all_to_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_http" {
  for_each          = { for k, v in local.security_group_rules_ooo_outbound_http : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_outbound_http_to_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_outbound_http_to_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_https" {
  for_each          = { for k, v in local.security_group_rules_ooo_outbound_https : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_outbound_https_to_source" {
  for_each                 = { for k, v in local.security_group_rules_ooo_outbound_https_to_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

/*

  * Custom port-based rules
  - Inbound in custom port based on CIDR
  - Inbound in custom port based on SG
  - Outbound in custom port based on CIDR
  - Outbound in custom port based on SG
*/
resource "aws_security_group_rule" "ooo_inbound_custom_port_cidr" {
  for_each          = { for k, v in local.security_group_rules_ooo_inbound_custom_port_cidr : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_inbound_custom_port_source_sg" {
  for_each                 = { for k, v in local.security_group_rules_ooo_inbound_custom_port_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}

resource "aws_security_group_rule" "ooo_outbound_custom_port_cidr" {
  for_each          = { for k, v in local.security_group_rules_ooo_outbound_custom_port_cidr : k => v }
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  security_group_id = aws_security_group.this[each.value["sg_name"]].id
}

resource "aws_security_group_rule" "ooo_outbound_custom_port_source_sg" {
  for_each                 = { for k, v in local.security_group_rules_ooo_outbound_custom_port_source : k => v }
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  security_group_id        = aws_security_group.this[each.value["sg_name"]].id
  source_security_group_id = each.value["source_security_group_id"]
}
