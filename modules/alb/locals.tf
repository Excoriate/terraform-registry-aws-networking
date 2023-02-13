locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
    * Enable ALB creation.
    * Enable ALB access logs (per ALB passed)
  */
  is_alb_enabled = !var.is_enabled ? false : var.alb_config != null

  alb_config_normalized = !local.is_alb_enabled ? [] : [
    for alb in var.alb_config : {
      name                             = lower(trimspace(alb.name))
      internal                         = alb["is_internal"] == null ? false : alb["is_internal"]
      load_balancer_type               = "application"
      security_groups                  = alb["security_groups"] == null ? [] : alb["security_groups"]
      subnets                          = alb["subnets_public"] == null ? [] : alb["subnets_public"]
      enable_cross_zone_load_balancing = alb["enable_cross_zone_load_balancing"] == null ? false : alb["enable_cross_zone_load_balancing"]
      enable_deletion_protection       = alb["enable_deletion_protection"] == null ? false : alb["enable_deletion_protection"]
      enable_http2                     = alb["enable_http2"] == null ? false : alb["enable_http2"]
      access_logs = alb["access_logs"] == null ? {} : {
        bucket  = trimspace(alb["access_logs"]["bucket"])
        prefix  = trimspace(alb["access_logs"]["prefix"])
        enabled = true
      }
    }
  ]

  alb_config_to_create = !local.is_alb_enabled ? {} : {
    for alb in local.alb_config_normalized : alb["name"] => {
      name                             = alb["name"]
      internal                         = alb["internal"]
      load_balancer_type               = alb["load_balancer_type"]
      security_groups                  = alb["security_groups"]
      subnets                          = alb["subnets"]
      enable_cross_zone_load_balancing = alb["enable_cross_zone_load_balancing"]
      enable_deletion_protection       = alb["enable_deletion_protection"]
      enable_http2                     = alb["enable_http2"]
      access_logs                      = alb["access_logs"]
    }
  }
}
