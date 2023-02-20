locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
  */
  is_zone_enabled = !var.is_enabled ? false : var.hosted_zone_config == null ? false : length(var.hosted_zone_config) != 0

  zone_config_normalized = !local.is_zone_enabled ? [] : [
    for zone in var.hosted_zone_config : {
      name    = lower(trimspace(zone["name"]))
      comment = zone["comment"] == null ? "" : zone["comment"]
      vpc_config = zone["vpc"] == null ? {} : {
        vpc_id     = zone["vpc"]["vpc_id"] == null ? null : zone["vpc"]["vpc_id"]
        vpc_region = zone["vpc"]["vpc_region"] == null ? null : zone["vpc"]["vpc_region"]
      }
      // Feature flags
      is_vpc_config_enabled = zone["vpc"] == null ? false : zone["vpc"]["vpc_id"] == null ? false : zone["vpc"]["vpc_id"] != ""
    }
  ]

  zone_config_to_create = !local.is_zone_enabled ? {} : {
    for zone in local.zone_config_normalized : zone["name"] => {
      name    = zone["name"]
      comment = zone["comment"]
      vpc     = zone["vpc_config"]

      // Feature flags
      is_vpc_config_enabled = zone["is_vpc_config_enabled"]
    }
  }

  /*
   * Zone delegation configuration.
  */
  is_zone_subdomains_config_enabled = !local.is_zone_enabled ? false : var.hosted_zone_subdomains == null ? false : length(var.hosted_zone_subdomains) != 0

  zone_subdomains_normalised = !local.is_zone_subdomains_config_enabled ? [] : [
    for zone in var.hosted_zone_subdomains : {
      name      = lower(trimspace(zone["name"]))
      subdomain = trimspace(zone["subdomain"])
      name_servers = zone["name_servers"] == null ? [] : [
        for ns in zone["name_servers"] : trimspace(ns)
      ]
      ttl = zone["ttl"] == null ? 60 : zone["ttl"]
    }
  ]

  zone_subdomains_to_create = !local.is_zone_subdomains_config_enabled ? {} : {
    for zone in local.zone_subdomains_normalised : zone["name"] => {
      name         = zone["name"]
      subdomain    = zone["subdomain"]
      name_servers = zone["name_servers"]
      ttl          = zone["ttl"]
    }
  }
}
