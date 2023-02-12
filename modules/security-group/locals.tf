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
