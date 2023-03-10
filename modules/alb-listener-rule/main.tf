resource "aws_lb_listener_rule" "rule_redirection" {
  for_each     = { for k, v in local.parent_config_to_create : k => v if v["type"] == "redirect" }
  listener_arn = each.value["listener_arn"]
  priority     = each.value["priority"]

  dynamic "action" {
    for_each = { for k, v in local.action_redirect_to_create : k => v if v["name"] == each.value["name"] && v["type"] == "redirect" }
    content {
      type = "redirect"
      dynamic "redirect" {
        for_each = [for rule in action.value["rules"] : rule]
        content {
          host        = redirect.value["host"]
          path        = redirect.value["path"]
          port        = redirect.value["port"]
          protocol    = redirect.value["protocol"]
          query       = redirect.value["query"]
          status_code = redirect.value["status_code"]
        }
      }
    }
  }

  dynamic "condition" {
    for_each = length([for c in local.conditions_set_normalised : c if c["name"] == each.value["name"]]) > 0 ? ["enabled"] : []
    content {
      dynamic "host_header" {
        for_each = length([for c in local.host_header_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.host_header_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = host_header.value
        }
      }

      dynamic "path_pattern" {
        for_each = length([for c in local.path_pattern_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.path_pattern_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = path_pattern.value
        }
      }

      dynamic "http_request_method" {
        for_each = length([for c in local.http_request_method_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.http_request_method_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = http_request_method.value
        }
      }

      dynamic "http_header" {
        for_each = length([for c in local.http_header_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.http_header_config_normalised : c if c["name"] == each.value["name"]] : []
        content {
          http_header_name = http_header.value["header"]
          values           = http_header.value["values"]
        }
      }

      dynamic "query_string" {
        for_each = length([for c in local.query_string_config_normalised : c if c["name"] == each.value["name"]]) > 0 ? [for c in local.query_string_config_normalised : c if c["name"] == each.value["name"]] : []
        content {
          key   = query_string.value["key"]
          value = query_string.value["value"]
        }
      }
    }
  }
}


resource "aws_lb_listener_rule" "rule_forward" {
  for_each     = { for k, v in local.parent_config_to_create : k => v if v["type"] == "forward" }
  listener_arn = each.value["listener_arn"]
  priority     = each.value["priority"]

  dynamic "action" {
    for_each = { for k, v in local.action_forward_to_create : k => v if v["name"] == each.value["name"] && v["type"] == "forward" }
    content {
      type = "forward"
      dynamic "forward" {
        for_each = [for rule in action.value["rules"] : rule if rule["target_group"] != null]
        iterator = rule_tg
        content {
          dynamic "target_group" {
            for_each = { for k, v in rule_tg.value["target_group"] : k => v }
            content {
              arn    = target_group.value["arn"]
              weight = target_group.value["weight"]
            }
          }
        }
      }
    }
  }

  dynamic "condition" {
    for_each = length([for c in local.conditions_set_normalised : c if c["name"] == each.value["name"]]) > 0 ? ["enabled"] : []
    content {
      dynamic "host_header" {
        for_each = length([for c in local.host_header_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.host_header_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = host_header.value
        }
      }

      dynamic "path_pattern" {
        for_each = length([for c in local.path_pattern_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.path_pattern_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = path_pattern.value
        }
      }

      dynamic "http_request_method" {
        for_each = length([for c in local.http_request_method_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.http_request_method_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = http_request_method.value
        }
      }

      dynamic "http_header" {
        for_each = length([for c in local.http_header_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.http_header_config_normalised : c if c["name"] == each.value["name"]] : []
        content {
          http_header_name = http_header.value["header"]
          values           = http_header.value["values"]
        }
      }

      dynamic "query_string" {
        for_each = length([for c in local.query_string_config_normalised : c if c["name"] == each.value["name"]]) > 0 ? [for c in local.query_string_config_normalised : c if c["name"] == each.value["name"]] : []
        content {
          key   = query_string.value["key"]
          value = query_string.value["value"]
        }
      }
    }
  }
}

resource "aws_lb_listener_rule" "rule_fixed_response" {
  for_each     = { for k, v in local.parent_config_to_create : k => v if v["type"] == "fixed-response" }
  listener_arn = each.value["listener_arn"]
  priority     = each.value["priority"]

  dynamic "action" {
    for_each = { for k, v in local.action_fixed_response_to_create : k => v if v["name"] == each.value["name"] && v["type"] == "fixed-response" }
    content {
      type = "fixed-response"
      dynamic "fixed_response" {
        for_each = [for rule in action.value["rules"] : rule if rule["status_code"] != null]
        content {
          content_type = fixed_response.value["content_type"]
          message_body = fixed_response.value["message_body"]
          status_code  = fixed_response.value["status_code"]
        }
      }
    }
  }

  dynamic "condition" {
    for_each = length([for c in local.conditions_set_normalised : c if c["name"] == each.value["name"]]) > 0 ? ["enabled"] : []
    content {
      dynamic "host_header" {
        for_each = length([for c in local.host_header_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.host_header_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = host_header.value
        }
      }

      dynamic "path_pattern" {
        for_each = length([for c in local.path_pattern_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.path_pattern_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = path_pattern.value
        }
      }

      dynamic "http_request_method" {
        for_each = length([for c in local.http_request_method_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.http_request_method_config_normalised : c["values"] if c["name"] == each.value["name"]] : []
        content {
          values = http_request_method.value
        }
      }

      dynamic "http_header" {
        for_each = length([for c in local.http_header_config_normalised : c["values"] if c["name"] == each.value["name"]]) > 0 ? [for c in local.http_header_config_normalised : c if c["name"] == each.value["name"]] : []
        content {
          http_header_name = http_header.value["header"]
          values           = http_header.value["values"]
        }
      }

      dynamic "query_string" {
        for_each = length([for c in local.query_string_config_normalised : c if c["name"] == each.value["name"]]) > 0 ? [for c in local.query_string_config_normalised : c if c["name"] == each.value["name"]] : []
        content {
          key   = query_string.value["key"]
          value = query_string.value["value"]
        }
      }
    }
  }
}
