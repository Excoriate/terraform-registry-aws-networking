locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy               = var.aws_region
  is_security_group_resource_enabled = !var.is_enabled ? false : var.security_group_config != null

  /*
    * Security group resource
    * It represent the main configuration, which can be created without rules.
  */
  sg_groups_normalised = !local.is_security_group_resource_enabled ? [] : [
    for group in var.security_group_config : {
      name        = (substr(group.name, 0, 3) == "sg-") ? substr(group.name, 3) : group.name
      description = lookup(group, "description", format("No description set for %s security group", group.name))
      vpc_id      = lookup(group, "vpc_id")
    }
  ]

  sg_groups_to_create = !local.is_security_group_resource_enabled ? {} : {
    for group in local.sg_groups_normalised : group["name"] => {
      name        = trimspace(lower(group["name"]))
      description = trimspace(group["description"])
      vpc_id      = trimspace(group["vpc_id"])
    }
  }

  /*
    * Security group rules
    * These rules works depending on whether the parent security group is created or not.
  */
  is_security_group_rules_enabled = !local.is_security_group_resource_enabled ? false : var.security_group_rules == null ? false : length(var.security_group_rules) > 0
  sg_group_rules_normalised = !local.is_security_group_rules_enabled ? [] : [
    for rule in var.security_group_rules : {
      // Mandatory set of parameters.
      sg_name     = (substr(rule["sg_parent"], 0, 3) == "sg-") ? substr(rule["sg_parent"], 3) : rule["sg_parent"]
      description = lookup(rule, "description", format("No description set for %s security group rule", rule["sg_parent"]))
      type        = rule["type"]
      from_port   = lookup(rule, "from_port", 0)
      to_port     = lookup(rule, "to_port", 0)
      protocol    = lookup(rule, "protocol", "tcp")
      // Optional set of parameters (self conflicts with source_security_group_id).
      cidr_blocks              = lookup(rule, "cidr_blocks", [])
      ipv6_cidr_blocks         = lookup(rule, "ipv6_cidr_blocks", [])
      prefix_list_ids          = lookup(rule, "prefix_list_ids", [])
      source_security_group_id = lookup(rule, "source_security_group_id", null)
      self                     = lookup(rule, "self", false)

      // Flags, for conflicting parameters. These flags helps to pass to the sg_group_rules_to_create only the valid parameters.
      is_cidr_blocks_enabled              = lookup(rule, "cidr_blocks", []) != [] ? true : false      // If true, it'll take precedence over the source_security_group_id, and self.
      is_ipv6_cidr_blocks_enabled         = lookup(rule, "ipv6_cidr_blocks", []) != [] ? true : false // If true, it'll take precedence over the source_security_group_id, and self
      is_self_enabled                     = lookup(rule, "self", false) != false ? true : false
      is_source_security_group_id_enabled = lookup(rule, "source_security_group_id", null) != null ? true : false
    }
  ]

  /*
    * CIDR based rules
    * -------------------------------------------------------------------
  */
  sg_group_rules_normalised_filtered_cidr = !local.is_security_group_rules_enabled ? [] : [
    for rule in local.sg_group_rules_normalised : rule if rule["is_cidr_blocks_enabled"] == true
  ]

  sg_group_rules_to_create_cidr_based = !local.is_security_group_rules_enabled ? {} : {
    for rule in local.sg_group_rules_normalised_filtered_cidr : rule["sg_name"] => {
      sg_name          = trimspace(lower(rule["sg_name"]))
      description      = trimspace(rule["description"])
      type             = trimspace(rule["type"])
      from_port        = rule["from_port"]
      to_port          = rule["to_port"]
      protocol         = trimspace(rule["protocol"])
      cidr_blocks      = rule["cidr_blocks"]
      ipv6_cidr_blocks = rule["ipv6_cidr_blocks"]
      prefix_list_ids  = rule["prefix_list_ids"]
    }
  }

  /*
    * SG -> to SG based rules
    * -------------------------------------------------------------------
  */
  sg_group_rules_normalised_filtered_source_sg = !local.is_security_group_rules_enabled ? [] : [
    for rule in local.sg_group_rules_normalised : rule if rule["is_source_security_group_id_enabled"] == true
  ]

  sg_group_rules_to_create_source_sg_based = !local.is_security_group_rules_enabled ? {} : {
    for rule in local.sg_group_rules_normalised_filtered_source_sg : rule["sg_name"] => {
      sg_name                  = trimspace(lower(rule["sg_name"]))
      description              = trimspace(rule["description"])
      type                     = trimspace(rule["type"])
      from_port                = rule["from_port"]
      to_port                  = rule["to_port"]
      protocol                 = trimspace(rule["protocol"])
      source_security_group_id = rule["source_security_group_id"]
    }
  }

  /*
    * SG -> Self based rules
    * -------------------------------------------------------------------
  */
  sg_group_rules_normalised_filtered_self = !local.is_security_group_rules_enabled ? [] : [
    for rule in local.sg_group_rules_normalised : rule if rule["is_self_enabled"] == true
  ]

  sg_group_rules_to_create_to_create_self_based = !local.is_security_group_rules_enabled ? {} : {
    for rule in local.sg_group_rules_normalised_filtered_self : rule["sg_name"] => {
      sg_name     = trimspace(lower(rule["sg_name"]))
      description = trimspace(rule["description"])
      type        = trimspace(rule["type"])
      from_port   = rule["from_port"]
      to_port     = rule["to_port"]
      protocol    = trimspace(rule["protocol"])
      self        = rule["self"]
    }
  }

  /*
    * Security group lookup options.
    * Lookup for the default VPC takes precedence over the lookup by name.
  */
  is_vpc_lookup_enabled         = !local.is_security_group_resource_enabled ? false : var.vpc_lookup_config == null ? false : var.vpc_lookup_config.is_default_vpc_enabled != false || var.vpc_lookup_config.vpc_name != null
  is_vpc_default_lookup_enabled = !local.is_vpc_lookup_enabled ? false : lookup(var.vpc_lookup_config, "is_default_vpc_enabled", false)
  is_vpc_named_lookup_enabled   = !local.is_vpc_lookup_enabled ? false : local.is_vpc_default_lookup_enabled ? false : length(trimspace(lower(lookup(var.vpc_lookup_config, "vpc_name")))) > 0
  vpc_lookup_name               = !local.is_vpc_named_lookup_enabled ? "" : trimspace(lower(lookup(var.vpc_lookup_config, "vpc_name")))

  vpc_looked_up = !local.is_vpc_lookup_enabled ? null : local.is_vpc_default_lookup_enabled ? data.aws_vpc.default[0].id : data.aws_vpc.named[0].id
}
