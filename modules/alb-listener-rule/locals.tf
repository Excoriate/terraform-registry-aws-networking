locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
   - Control each specific rule configuration.
   - Control each specific condition configuration.
  */
  is_enabled                           = !var.is_enabled ? false : var.listener_rules_config == null ? false : length(var.listener_rules_config) > 0
  is_action_redirect_set               = !local.is_enabled ? false : var.action_redirect_config == null ? false : length(var.action_redirect_config) > 0
  is_action_forward_set                = !local.is_enabled ? false : var.action_forward_config == null ? false : length(var.action_forward_config) > 0
  is_action_fixed_response_set         = !local.is_enabled ? false : var.action_fixed_response_config == null ? false : length(var.action_fixed_response_config) > 0
  is_action_ooo_https_redirect_enabled = !var.is_enabled ? false : var.action_redirect_https == null ? false : length(var.action_redirect_https) > 0
  #  is_action_authenticate_cognito_set = !local.is_enabled ? false : var.action_authenticate_cognito_config == null ? false : length(var.action_authenticate_cognito_config) > 0
  are_conditions_set = !local.is_enabled ? false : var.conditions_config == null ? false : length(var.conditions_config) > 0

  // Main configuration that'll be merged with specific rules and conditions accordingly.
  parent_config = !local.is_enabled ? [] : [
    for config in var.listener_rules_config : {
      name         = lower(trimspace(config.name))
      listener_arn = trimspace(config.listener_arn)
      priority     = config["priority"] == null ? null : config["priority"]
      type         = config["type"] == null ? "forward" : trimspace(config["type"])
    }
  ]
  parent_config_to_create = !local.is_enabled ? {} : local.is_action_ooo_https_redirect_enabled ? {} : { for config in local.parent_config : config["name"] => config
  }

  /*
   * Rules configuration
   * ------------------------------------
   * Rule/Action: redirection
   * ------------------------------------
  */
  action_redirect_normalised = !local.is_action_redirect_set ? [] : [
    for action in var.action_redirect_config : {
      name = lower(trimspace(action.name))
      type = "redirect"
      rules = [
        for rule in action.rules : {
          host        = rule["host"] == null ? null : trimspace(rule["host"])
          path        = rule["path"] == null ? null : trimspace(rule["path"])
          port        = rule["port"] == null ? null : trimspace(rule["port"])
          protocol    = rule["protocol"] == null ? null : trimspace(rule["protocol"])
          query       = rule["query"] == null ? null : trimspace(rule["query"])
          status_code = rule["status_code"] == null ? "HTTP_301" : trimspace(rule["status_code"])
        }
      ]
    }
  ]

  action_redirect_to_create = !local.is_action_redirect_set ? {} : {
    for action in local.action_redirect_normalised : action["name"] => action
  }

  /*
   * Rules configuration
   * ------------------------------------
   * Rule/Action: fixed response
   * ------------------------------------
  */
  action_fixed_response_normalised = !local.is_action_fixed_response_set ? [] : [
    for action in var.action_fixed_response_config : {
      name = lower(trimspace(action.name))
      type = "fixed-response"
      rules = [
        for rule in action.rules : {
          content_type = rule["content_type"] == null ? null : trimspace(rule["content_type"])
          message_body = rule["message_body"] == null ? null : trimspace(rule["message_body"])
          status_code  = rule["status_code"] == null ? null : trimspace(rule["status_code"])
        }
      ]
    }
  ]

  action_fixed_response_to_create = !local.is_action_fixed_response_set ? {} : {
    for action in local.action_fixed_response_normalised : action["name"] => action
  }


  /*
   * Rules configuration
   * ------------------------------------
   * Rule/Action: forward
   * ------------------------------------
  */
  action_forward_normalised = !local.is_action_forward_set ? [] : [
    for action in var.action_forward_config : {
      name = lower(trimspace(action.name))
      type = "forward"
      rules = [
        for rule in action.rules : {
          target_group_arn = rule["target_group_arn"] == null ? null : trimspace(rule["target_group_arn"])
          stickiness = rule["stickiness"] == null ? null : {
            duration = rule["stickiness"]["duration"] == null ? null : trimspace(rule["stickiness"]["duration"])
            enabled  = rule["stickiness"]["enabled"] == null ? null : rule["stickiness"]["enabled"]
          }
          target_group = rule["target_group"] == null ? [] : [
            for tg in rule["target_group"] : {
              arn    = tg["arn"] == null ? null : trimspace(tg["arn"])
              weight = tg["weight"] == null ? null : trimspace(tg["weight"])
            }
          ]
        }
      ]
    }
  ]

  action_forward_to_create = !local.is_action_forward_set ? {} : {
    for action in local.action_forward_normalised : action["name"] => action
  }

  /*
   * Condition configuration
   * This collection and subsequent map check which option was set, to selectively pick them up when the rule is created.
  */
  conditions_set_normalised = !local.are_conditions_set ? [] : [
    for c in var.conditions_config : {
      name = lower(trimspace(c.name))
      conditions = [
        for condition in c.conditions : {
          is_host_header_enabled         = condition["host_header_config"] != null
          is_path_pattern_enabled        = condition["path_pattern_config"] != null
          is_http_header_enabled         = condition["http_header_config"] != null
          is_http_request_method_enabled = condition["http_request_method_config"] != null
          is_query_string_config_enabled = condition["query_string_config"] != null
        }
      ]
    }
  ]

  /*
   * Condition configuration
   * This collection and subsequent map check which option was set, to selectively pick them up when the rule is created.
   * This act upon the 'host_header_config' condition.
  */
  host_header_config_normalised = !local.are_conditions_set ? [] : [
    for condition in var.conditions_config : {
      name   = lower(trimspace(condition.name))
      values = [for c in condition.conditions : c["host_header_config"]][0]
    } if[for c in condition.conditions : c["host_header_config"]][0] != null
  ]

  /*
   * Condition configuration
   * This collection and subsequent map check which option was set, to selectively pick them up when the rule is created.
   * This act upon the 'path_pattern_config' condition.
  */
  path_pattern_config_normalised = !local.are_conditions_set ? [] : [
    for condition in var.conditions_config : {
      name   = lower(trimspace(condition.name))
      values = [for c in condition.conditions : c["path_pattern_config"]][0]
    } if[for c in condition.conditions : c["path_pattern_config"]][0] != null
  ]

  /*
   * Condition configuration
   * This collection and subsequent map check which option was set, to selectively pick them up when the rule is created.
   * This act upon the 'http_request_method' condition.
  */
  http_request_method_config_normalised = !local.are_conditions_set ? [] : [
    for condition in var.conditions_config : {
      name   = lower(trimspace(condition.name))
      values = [for c in condition.conditions : c["http_request_method_config"]][0]
    } if[for c in condition.conditions : c["http_request_method_config"]][0] != null
  ]

  /*
   * Condition configuration
   * This collection and subsequent map check which option was set, to selectively pick them up when the rule is created.
   * This act upon the 'http_header_config' condition.
  */
  http_header_config_normalised = !local.are_conditions_set ? [] : [
    for condition in var.conditions_config : {
      name   = lower(trimspace(condition.name))
      header = [for c in condition.conditions : c["http_header_config"]][0]["header"]
      values = [for c in condition.conditions : c["http_header_config"]][0]["values"]
    } if[for c in condition.conditions : c["http_header_config"]][0] != null
  ]

  /*
   * Condition configuration
   * This collection and subsequent map check which option was set, to selectively pick them up when the rule is created.
   * This act upon the 'query_string_config' condition.
  */
  query_string_config_normalised = !local.are_conditions_set ? [] : [
    for condition in var.conditions_config : {
      name  = lower(trimspace(condition.name))
      key   = [for c in condition.conditions : c["query_string_config"]][0]["key"]
      value = [for c in condition.conditions : c["query_string_config"]][0]["value"]
    } if[for c in condition.conditions : c["query_string_config"]][0] != null
  ]

  /*
   * Set of OOO actions
   * 1. HTTPs redirection
  */
  action_redirect_https_normalised = !local.is_action_ooo_https_redirect_enabled ? [] : [
    for action in var.action_redirect_https : {
      name                 = lower(trimspace(action.name))
      type                 = "redirect"
      redirect_port        = 443
      priority             = action["priority"] == null ? null : action["priority"]
      listener_arn         = action["listener_arn"]
      redirect_protocol    = "HTTPS"
      redirect_status_code = "HTTP_301"
      conditions = action["host_header_condition"] == null && action["http_header_condition"] == null && action["path_pattern_condition"] == null ? {} : {
        http_header  = action["http_header_condition"] == null ? null : { for k, v in action["http_header_condition"] : k => v }
        host_header  = action["host_header_condition"] == null ? null : [for host_header in action["host_header_condition"] : host_header]
        path_pattern = action["path_pattern_condition"] == null ? null : [for path_pattern in action["path_pattern_condition"] : path_pattern]
      }

      is_condition_block_enabled        = action["host_header_condition"] == null && action["http_header_condition"] == null && action["path_pattern_condition"] == null ? false : true
      is_host_header_condition_enabled  = action["host_header_condition"] == null ? false : length(action["host_header_condition"]) > 0
      is_http_header_condition_enabled  = action["http_header_condition"] == null ? false : true
      is_path_pattern_condition_enabled = action["path_pattern_condition"] == null ? false : length(action["path_pattern_condition"]) > 0
    }
  ]

  action_redirect_https_create = !local.is_action_ooo_https_redirect_enabled ? {} : { for action in local.action_redirect_https_normalised : action["name"] => action }

}
