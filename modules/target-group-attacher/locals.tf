locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
  */
  is_enabled = !var.is_enabled ? false : var.attachment_config == null ? false : length(var.attachment_config) > 0

  attachments_normalised = !local.is_enabled ? [] : [
    for at in var.attachment_config : {
      name              = lower(trimspace(at.name))
      backend_id        = lower(trimspace(at.backend_id))
      target_group_arn  = lower(trimspace(at.target_group_arn))
      availability_zone = at["availability_zone"] == null ? null : lower(trimspace(at.availability_zone))
      port              = at["port"] == null ? null : lower(trimspace(at.port))
    }
  ]

  attachments_to_create = !local.is_enabled ? {} : {
    for at in local.attachments_normalised : at["name"] => at
  }
}
