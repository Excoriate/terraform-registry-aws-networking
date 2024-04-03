locals {
  ###################################
  # Feature Flags ⛳️
  # ----------------------------------------------------
  #
  # These flags are used to enable or disable certain features.
  # 1. `is_enabled` - This flag is used to enable or disable the security group feature.
  #
  ###################################
  is_enabled = var.is_enabled && var.security_group_config != null

  ###################################
  # Normalized & CLeaned Variables 🧹
  # ----------------------------------------------------
  #
  # These variables are used to normalize and clean the input variables.
  # 1. `name` - The name of the security group. This logic: (substr(group.name, 0, 3) == "sg-") ? substr(group.name, 3) : group.name
  #    is used to remove the `sg-` prefix from the security group name if it exists.
  #
  ###################################
  sg_groups_normalised = local.is_enabled ? [
    for group in [var.security_group_config] : {
      name        = substr(group.name, 0, 3) == "sg-" ? substr(group.name, 3, length(group.name)-3) : group.name,
      description = group.description != "" ? group.description : format("No description set for %s security group", group.name)
      vpc_id      = group.vpc_id
      ingress     = group.ingress != null ? group.ingress : []
      egress      = group.egress != null ? group.egress : []
    }
  ] : []

  sg_groups_to_create = {
    for group in local.sg_groups_normalised : group["name"] => group
  }
}
