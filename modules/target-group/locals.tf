locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
    * Enable target group creation.
  */
  is_target_group_enabled = !var.is_enabled ? false : var.target_group_config != null

  target_group_alb_normalised = !local.is_target_group_enabled ? [] : [
    for tg in var.target_group_config : {
      name                          = trimspace(tg["name"])
      port                          = tg.port
      protocol                      = upper(trimspace(tg["protocol"]))
      protocol_version              = tg["protocol_version"] == null ? null : upper(trimspace(tg["protocol_version"]))
      slow_start                    = tg["slow_start"] == null ? 0 : tg["slow_start"]
      deregistration_delay          = tg["deregistration_delay"] == null ? 300 : tg["deregistration_delay"]
      load_balancing_algorithm_type = tg["load_balancing_algorithm_type"] == null ? "round_robin" : tg["load_balancing_algorithm_type"]
      vpc_id                        = tg["vpc_id"]
      target_type                   = tg["target_type"] == null ? "ip" : trimspace(tg["target_type"])
      health_check = tg["health_check"] == null ? null : {
        enabled             = true
        path                = tg["health_check"]["path"]
        port                = tg["health_check"]["port"]
        protocol            = upper(trimspace(tg["health_check"]["protocol"]))
        healthy_threshold   = tg["health_check"]["healthy_threshold"]
        unhealthy_threshold = tg["health_check"]["unhealthy_threshold"]
        timeout             = tg["health_check"]["timeout"]
        interval            = tg["health_check"]["interval"]
        matcher             = tg["health_check"]["matcher"]
      }
      stickiness = tg["stickiness"] == null ? null : {
        type            = tg["stickiness"]["type"]
        cookie_duration = tg["stickiness"]["cookie_duration"]
        cookie_name     = tg["stickiness"]["cookie_name"]
      }
    }
  ]

  target_group_alb_to_create = !local.is_target_group_enabled ? {} : {
    for tg in local.target_group_alb_normalised : tg["name"] => {
      name                          = tg["name"]
      port                          = tg["port"]
      protocol                      = tg["protocol"]
      protocol_version              = tg["protocol_version"]
      slow_start                    = tg["slow_start"]
      deregistration_delay          = tg["deregistration_delay"]
      load_balancing_algorithm_type = tg["load_balancing_algorithm_type"]
      vpc_id                        = tg["vpc_id"]
      target_type                   = tg["target_type"]
      health_check = tg["health_check"] == null ? null : {
        enabled             = tg["health_check"]["enabled"]
        path                = tg["health_check"]["path"]
        port                = tg["health_check"]["port"]
        protocol            = tg["health_check"]["protocol"]
        healthy_threshold   = tg["health_check"]["healthy_threshold"]
        unhealthy_threshold = tg["health_check"]["unhealthy_threshold"]
        timeout             = tg["health_check"]["timeout"]
        interval            = tg["health_check"]["interval"]
        matcher             = tg["health_check"]["matcher"]
      }
      stickiness = tg["stickiness"] == null ? null : {
        type            = tg["stickiness"]["type"]
        cookie_duration = tg["stickiness"]["cookie_duration"]
        cookie_name     = tg["stickiness"]["cookie_name"]
      }
    }
  }
}
