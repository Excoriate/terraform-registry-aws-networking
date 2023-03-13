locals {
  aws_region_to_deploy = var.aws_region
  /*
    * The following variables are used to create the security group. Control flags:
    - is_enabled: if set to false, the security group will not be created
    - Check if either of the rules allowed options are set.
  */
  is_enabled              = !var.is_enabled ? false : var.security_group_config == null ? false : length(var.security_group_config) > 0
  is_sg_rules_ooo_enabled = !local.is_enabled ? false : var.security_group_rules_ooo == null ? false : length(var.security_group_rules_ooo) > 0
  is_sg_rules_enabled     = !local.is_enabled ? false : var.security_group_rules == null ? false : length(var.security_group_rules) > 0

  /*
    * Lookup configuration for an existing security group.
  */
  sg_normalised = !local.is_enabled ? [] : [
    for sg in var.security_group_config : {
      name        = trimspace(lower(sg.name))
      sg_name     = trimspace(lower(sg["sg_name"]))
      sg_id       = sg["sg_id"] == null ? null : trimspace(lower(sg["sg_id"]))
      description = format("Security group rule for sg %s", sg.name)

      // feature flags. If id is passed, it'll take precedence.
      lookup_by_id_enabled   = sg["sg_id"] == null ? false : sg["sg_id"] == "" ? false : true
      lookup_by_name_enabled = sg["sg_name"] == null ? false : sg.sg_name == "" ? false : true
    }
  ]

  sg_create = !local.is_enabled ? {} : {
    for sg in local.sg_normalised : sg["name"] => sg
  }

  /*
    * 1. OOO (out-of-the-box rules)
  */
  sg_rules_ooo_normalised = !local.is_sg_rules_ooo_enabled ? [] : [
    for sg_rule in var.security_group_rules_ooo : {
      name                               = trimspace(lower(sg_rule.name))
      sg_name                            = trimspace(lower(sg_rule["sg_name"]))
      sg_id                              = sg_rule["sg_id"] == null ? null : trimspace(lower(sg_rule["sg_id"]))
      description                        = format("Security group rule for sg %s", sg_rule.name)
      enable_inbound_all_traffic         = sg_rule["enable_inbound_all_traffic"] == null ? false : sg_rule["enable_inbound_all_traffic"]
      enable_inbound_all_http            = sg_rule["enable_inbound_all_http"] == null ? false : sg_rule["enable_inbound_all_http"]
      enable_inbound_all_https           = sg_rule["enable_inbound_all_https"] == null ? false : sg_rule["enable_inbound_all_https"]
      enable_inbound_all_https_from_sg   = sg_rule["enable_inbound_all_https_from_sg"] == null ? false : sg_rule["enable_inbound_all_https_from_sg"]
      enable_inbound_all_http_from_sg    = sg_rule["enable_inbound_all_http_from_sg"] == null ? false : sg_rule["enable_inbound_all_http_from_sg"]
      enable_inbound_all_traffic_from_sg = sg_rule["enable_inbound_all_traffic_from_sg"] == null ? false : sg_rule["enable_inbound_all_traffic_from_sg"]
      enable_outbound_all_traffic        = sg_rule["enable_outbound_all_traffic"] == null ? false : sg_rule["enable_outbound_all_traffic"]
      enable_outbound_all_traffic_to_sg  = sg_rule["enable_outbound_all_traffic_to_sg"] == null ? false : sg_rule["enable_outbound_all_traffic_to_sg"]
      enable_outbound_all_http           = sg_rule["enable_outbound_all_http"] == null ? false : sg_rule["enable_outbound_all_http"]
      enable_outbound_all_http_to_sg     = sg_rule["enable_outbound_all_http_to_sg"] == null ? false : sg_rule["enable_outbound_all_http_to_sg"]
      enable_outbound_all_https          = sg_rule["enable_outbound_all_https"] == null ? false : sg_rule["enable_outbound_all_https"]
      enable_outbound_all_https_to_sg    = sg_rule["enable_outbound_all_https_to_sg"] == null ? false : sg_rule["enable_outbound_all_https_to_sg"]
      source_security_group_id           = sg_rule["source_security_group_id"] == null ? null : trimspace(lower(sg_rule["source_security_group_id"]))
      cidr_blocks                        = sg_rule["cidr_blocks"] == null ? ["0.0.0.0/0"] : [for cidr in sg_rule["cidr_blocks"] : trimspace(lower(cidr))]
      custom_port                        = sg_rule["custom_port"] == null ? null : sg_rule["custom_port"]

      // Security groups
      is_source_sg_enabled   = sg_rule["source_security_group_id"] != null
      is_custom_port_enabled = sg_rule["custom_port"] != null
    }
  ]

  sg_rules_ooo_create = !local.is_sg_rules_ooo_enabled ? {} : {
    for sg_rule in local.sg_rules_ooo_normalised : sg_rule["name"] => sg_rule
  }

  /*
    * 2. Custom rules
  */
  sg_rules_custom_normalised = !local.is_sg_rules_enabled ? [] : [
    for sg_rule in var.security_group_rules : {
      name                     = trimspace(lower(sg_rule.name))
      sg_name                  = trimspace(lower(sg_rule["sg_name"]))
      sg_id                    = sg_rule["sg_id"] == null ? null : trimspace(lower(sg_rule["sg_id"]))
      description              = format("Security group (custom) rule for sg %s", sg_rule.name)
      source_security_group_id = sg_rule["source_security_group_id"] == null ? null : trimspace(lower(sg_rule["source_security_group_id"]))
      type                     = sg_rule["type"] == null ? "ingress" : trimspace(lower(sg_rule["type"]))
      from_port                = sg_rule["from_port"]
      to_port                  = sg_rule["to_port"]
      protocol                 = sg_rule["protocol"] == null ? "tcp" : trimspace(lower(sg_rule["protocol"]))
      cidr_blocks              = sg_rule["cidr_blocks"] == null ? ["0.0.0.0/0"] : [for cidr in sg_rule["cidr_blocks"] : trimspace(lower(cidr))]
      ipv6_cidr_blocks         = sg_rule["ipv6_cidr_blocks"] == null ? null : [for cidr in sg_rule["ipv6_cidr_blocks"] : trimspace(lower(cidr))]
      prefix_list_ids          = sg_rule["prefix_list_ids"] == null ? null : [for cidr in sg_rule["prefix_list_ids"] : trimspace(lower(cidr))]
      self                     = sg_rule["self"] == null ? false : sg_rule["self"]

      // feature flags
      is_source_sg_enabled = sg_rule["source_security_group_id"] != null
    }
  ]

  sg_rules_custom_create = !local.is_sg_rules_enabled ? {} : {
    for sg_rule in local.sg_rules_custom_normalised : sg_rule["name"] => sg_rule
  }
}
