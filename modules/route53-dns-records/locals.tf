locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
  */
  is_dns_alias_enabled = !var.is_enabled ? false : var.record_type_alias_config == null ? false : length(var.record_type_alias_config) != 0

  dns_alias_normalized = !local.is_dns_alias_enabled ? [] : [
    for record in var.record_type_alias_config : {
      name            = record["name"]
      zone_name       = record["zone_name"] == null ? null : trimspace(record["zone_name"])
      zone_id         = record["zone_id"] == null ? null : trimspace(record["zone_id"])
      allow_overwrite = record["allow_overwrite"] == null ? false : record["allow_overwrite"]
      ttl             = record["ttl"] == null ? 60 : record["ttl"]
      alias = record["alias_target_config"] == null ? {} : {
        name                   = trimspace(record["alias_target_config"]["target_dns_name"])
        zone_id                = trimspace(record["alias_target_config"]["target_zone_id"])
        evaluate_target_health = record["alias_target_config"]["target_enable_health_check"] == null ? false : record["alias_target_config"]["target_enable_health_check"]
      }
      // Feature flags.
      is_zone_lookup_by_zone_id_enabled   = record["zone_id"] != null
      is_zone_lookup_by_zone_name_enabled = record["zone_name"] != null // Name will take precedence
    }
  ]

  dns_alias_to_create = !local.is_dns_alias_enabled ? {} : {
  for record in local.dns_alias_normalized : record["name"] => record }
}
