locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
   * Currently, there are two options allowed: hosted zones, and subdomains (hosted zones with NS records).
  */
  is_hosted_zone_stand_alone_enabled  = !var.is_enabled ? false : var.hosted_zone_stand_alone == null ? false : length(var.hosted_zone_stand_alone) != 0
  is_hosted_zone_name_servers_enabled = !var.is_enabled ? false : !local.is_hosted_zone_stand_alone_enabled ? false : var.hosted_zone_stand_alone_name_servers == null ? false : length(var.hosted_zone_stand_alone_name_servers) != 0

  hosted_zones_stand_alone_normalised = !local.is_hosted_zone_stand_alone_enabled ? [] : [
    for zone in var.hosted_zone_stand_alone : {
      name              = lower(trimspace(zone["name"]))
      comment           = zone["comment"] == null ? "Managed by terraform. Standalone DNS zone." : zone["comment"]
      force_destroy     = zone["force_destroy"] == null ? false : zone["force_destroy"]
      delegation_set_id = zone["delegation_set_id"] == null ? null : zone["delegation_set_id"]
      vpc = zone["vpc"] == null ? {} : {
        vpc_id     = zone["vpc"]["vpc_id"] == null ? null : zone["vpc"]["vpc_id"]
        vpc_region = zone["vpc"]["vpc_region"] == null ? null : zone["vpc"]["vpc_region"]
      }
      // Feature flags
      is_vpc_config_enabled = zone["vpc"] == null ? false : zone["vpc"]["vpc_id"] == null ? false : zone["vpc"]["vpc_id"] != ""
    }
  ]

  hosted_zone_stand_alone_name_severs = !local.is_hosted_zone_name_servers_enabled ? [] : [
    for zone in var.hosted_zone_stand_alone_name_servers : {
      hosted_zone_name = lower(trimspace(zone["hosted_zone_name"]))
      record_name      = lower(trimspace(zone["record_name"]))
      name_servers     = zone["name_servers"] == null ? [] : [for ns in zone["name_servers"] : lower(trimspace(ns))]
      ttl              = zone["ttl"] == null ? 30 : zone["ttl"]
    }
  ]

  hosted_zone_stand_alone_name_servers_to_create = !local.is_hosted_zone_name_servers_enabled ? {} : {
    for zone in local.hosted_zone_stand_alone_name_severs : zone["record_name"] => {
      zone    = zone["hosted_zone_name"]
      records = zone["name_servers"]
      name    = zone["record_name"]
      ttl     = zone["ttl"]
    }
  }

  hosted_zone_config_to_create = !local.is_hosted_zone_stand_alone_enabled ? {} : {
    for zone in local.hosted_zones_stand_alone_normalised : zone["name"] => {
      name              = zone["name"]
      comment           = zone["comment"]
      vpc               = zone["vpc"]
      force_destroy     = zone["force_destroy"]
      delegation_set_id = zone["delegation_set_id"]

      // Feature flags
      is_vpc_config_enabled = zone["is_vpc_config_enabled"]
    }
  }

  /*
   * Subdomains
   * It requires two configurations to be enabled: the parent hosted zone, and the subdomain(s).
  */

  is_hosted_zone_subdomains_parent_set = !var.is_enabled ? false : var.hosted_zone_subdomains_parent == null ? false : true
  is_hosted_zone_subdomains_childs_set = !var.is_enabled ? false : var.hosted_zone_subdomains_childs == null ? false : length(var.hosted_zone_subdomains_childs) != 0
  is_hosted_zone_subdomains_enabled    = local.is_hosted_zone_subdomains_parent_set && local.is_hosted_zone_subdomains_childs_set

  subdomains_parent_normalised = !local.is_hosted_zone_subdomains_enabled ? null : {
    name              = lower(trimspace(var.hosted_zone_subdomains_parent.name))
    comment           = lookup(var.hosted_zone_subdomains_parent, "comment", null) == null ? "Managed by terraform. Parent DNS zone for subdomains." : var.hosted_zone_subdomains_parent.comment
    force_destroy     = lookup(var.hosted_zone_subdomains_parent, "force_destroy", null) == null ? false : var.hosted_zone_subdomains_parent.force_destroy
    delegation_set_id = lookup(var.hosted_zone_subdomains_parent, "delegation_set_id", null) == null ? null : var.hosted_zone_subdomains_parent.delegation_set_id
    vpc = lookup(var.hosted_zone_subdomains_parent, "vpc", null) == null ? {} : {
      vpc_id     = lookup(var.hosted_zone_subdomains_parent.vpc, "vpc_id", null) == null ? null : var.hosted_zone_subdomains_parent.vpc.vpc_id
      vpc_region = lookup(var.hosted_zone_subdomains_parent.vpc, "vpc_region", null) == null ? null : var.hosted_zone_subdomains_parent.vpc.vpc_region
    }
    // Feature flags
    is_vpc_config_enabled = lookup(var.hosted_zone_subdomains_parent, "vpc", null) == null ? false : lookup(var.hosted_zone_subdomains_parent.vpc, "vpc_id", null) == null ? false : var.hosted_zone_subdomains_parent.vpc.vpc_id != ""
  }

  subdomains_parent_to_create = !local.is_hosted_zone_subdomains_enabled ? null : {
    for k, v in local.subdomains_parent_normalised : k => v
  }

  subdomains_childs_normalised = !local.is_hosted_zone_subdomains_enabled ? [] : [
    for zone in var.hosted_zone_subdomains_childs : {
      name              = lower(trimspace(zone["name"]))
      domain            = lower(trimspace(zone["domain"]))
      subdomain         = format("%s.%s", trimspace(zone["name"]), trimspace(zone["domain"]))
      comment           = zone["comment"] == null ? "Managed by terraform. Subdomain DNS zone." : zone["comment"]
      force_destroy     = zone["force_destroy"] == null ? false : zone["force_destroy"]
      delegation_set_id = zone["delegation_set_id"] == null ? null : zone["delegation_set_id"]
      ttl               = zone["ttl"] == null ? 30 : zone["ttl"]
      vpc = zone["vpc"] == null ? {} : {
        vpc_id     = zone["vpc"]["vpc_id"] == null ? null : zone["vpc"]["vpc_id"]
        vpc_region = zone["vpc"]["vpc_region"] == null ? null : zone["vpc"]["vpc_region"]
      }
      // Feature flags
      is_vpc_config_enabled = zone["vpc"] == null ? false : zone["vpc"]["vpc_id"] == null ? false : zone["vpc"]["vpc_id"] != ""
    }
  ]

  subdomains_childs_to_create = !local.is_hosted_zone_subdomains_enabled ? {} : {
    for zone in local.subdomains_childs_normalised : zone["subdomain"] => {
      name              = zone["name"]
      domain            = zone["domain"]
      subdomain         = zone["subdomain"]
      comment           = zone["comment"]
      force_destroy     = zone["force_destroy"]
      delegation_set_id = zone["delegation_set_id"]
      vpc               = zone["vpc"]
      ttl               = zone["ttl"]

      // Feature flags
      is_vpc_config_enabled = zone["is_vpc_config_enabled"]
    }
  }
}
