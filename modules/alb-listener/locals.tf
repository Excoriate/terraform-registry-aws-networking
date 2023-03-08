locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
    * Enable ALB listeners configuration.
  */
  is_alb_listeners_enabled          = !var.is_enabled ? false : var.alb_listeners_config != null
  is_alb_listener_ooo_http_enabled  = !var.is_enabled ? false : var.alb_listener_ooo_http == null ? false : length(var.alb_listener_ooo_http) > 0
  is_alb_listener_ooo_https_enabled = !var.is_enabled ? false : var.alb_listener_ooo_https == null ? false : length(var.alb_listener_ooo_https) > 0

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
        forward = listener["default_action"]["forward"] != null ? {
          target_group = listener["default_action"]["forward"]["target_group"]
          stickiness = listener["default_action"]["forward"]["stickiness"] != null ? {
            duration_seconds = listener["default_action"]["forward"]["stickiness"]["duration_seconds"]
            enabled          = listener["default_action"]["forward"]["stickiness"]["enabled"]
          } : null
        } : null
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

  /*
    * ALB listener for HTTP.
    - Set of OOO default (ready-to-use) listeners, with common configurations for HTTP.
  */
  alb_listeners_http_normalised = !local.is_alb_listener_ooo_http_enabled ? [] : [
    for listener in var.alb_listener_ooo_http : {
      name            = trimspace(listener["name"])
      alb_arn         = trimspace(listener["alb_arn"])
      port            = 80
      protocol        = "HTTP"
      ssl_policy      = null
      certificate_arn = null
      default_action = {
        type             = "forward"
        target_group_arn = trimspace(listener["target_group_arn"])
      }
    }
  ]

  alb_listeners_http_to_create = !local.is_alb_listener_ooo_http_enabled ? {} : {
    for listener in local.alb_listeners_http_normalised : listener["name"] => {
      name            = listener["name"]
      alb_arn         = listener["alb_arn"]
      port            = listener["port"]
      protocol        = listener["protocol"]
      ssl_policy      = listener["ssl_policy"]
      certificate_arn = listener["certificate_arn"]
      default_action  = listener["default_action"]
    }
  }

  /*
    * ALB listener for HTTPS.
    - Set of OOO default (ready-to-use) listeners, with common configurations for HTTPS.
  */
  alb_listeners_https_normalised = !local.is_alb_listener_ooo_https_enabled ? [] : [
    for listener in var.alb_listener_ooo_https : {
      name            = trimspace(listener["name"])
      alb_arn         = trimspace(listener["alb_arn"])
      port            = 443
      protocol        = "HTTPS"
      ssl_policy      = "ELBSecurityPolicy-2016-08"
      certificate_arn = trimspace(listener["certificate_arn"])
      default_action = {
        type             = "forward"
        target_group_arn = trimspace(listener["target_group_arn"])
      }
    }
  ]

  alb_listeners_https_to_create = !local.is_alb_listener_ooo_https_enabled ? {} : {
    for listener in local.alb_listeners_https_normalised : listener["name"] => {
      name            = listener["name"]
      alb_arn         = listener["alb_arn"]
      port            = listener["port"]
      protocol        = listener["protocol"]
      ssl_policy      = listener["ssl_policy"]
      certificate_arn = listener["certificate_arn"]
      default_action  = listener["default_action"]
    }
  }
}
