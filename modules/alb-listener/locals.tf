locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
    * Enable ALB listeners configuration.
  */
  is_alb_listeners_enabled = !var.is_enabled ? false : var.alb_listeners_config != null

  alb_listener_normalized = !local.is_alb_listeners_enabled ? [] : [
    for listener in var.alb_listeners_config : {
      alb_arn         = trimspace(listener["alb_arn"])
      port            = listener["port"]
      protocol        = upper(trimspace(listener["protocol"]))
      ssl_policy      = listener["ssl_policy"]
      certificate_arn = listener["certificate_arn"]
      default_action = listener["default_action"] != null ? {
        type             = listener["default_action"]["type"] != null ? listener["default_action"]["type"] : "forward"
        target_group_arn = listener["default_action"]["target_group_arn"]
      } : null
    }
  ]

  alb_listener_to_create = !local.is_alb_listeners_enabled ? {} : {
    for listener in local.alb_listener_normalized : listener["alb_arn"] => {
      alb_arn         = listener["alb_arn"]
      port            = listener["port"]
      protocol        = listener["protocol"]
      ssl_policy      = listener["ssl_policy"]
      certificate_arn = listener["certificate_arn"]
      default_action  = listener["default_action"]
    }
  }
}
