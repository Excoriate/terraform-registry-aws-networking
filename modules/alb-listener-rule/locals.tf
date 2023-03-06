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
  is_enabled             = !var.is_enabled ? false : var.listener_rules_config == null ? false : length(var.listener_rules_config) > 0
  is_action_redirect_set = !local.is_enabled ? false : var.action_redirect_config == null ? false : length(var.action_redirect_config) > 0
  are_conditions_set     = !local.is_enabled ? false : var.conditions_config == null ? false : length(var.conditions_config) > 0

  // Main configuration that'll be merged with specific rules and conditions accordingly.
  parent_config = !local.is_enabled ? [] : [
    for config in var.listener_rules_config : {
      name         = lower(trimspace(config.name))
      listener_arn = trimspace(config.listener_arn)
      priority     = config["priority"] == null ? null : config["priority"]
    }
  ]

  parent_config_to_create = !local.is_enabled ? {} : {
    for config in local.parent_config : config["name"] => config
  }

  /*
   * Rule configuration
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
}
