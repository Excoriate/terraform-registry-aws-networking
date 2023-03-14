resource "aws_lb_listener_rule" "ooo_redirect_https" {
  for_each     = local.action_redirect_https_create
  listener_arn = each.value["listener_arn"]
  priority     = each.value["priority"]

  action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  dynamic "condition" {
    for_each = !each.value["is_condition_block_enabled"] ? {} : each.value["conditions"]
    content {
      dynamic "host_header" {
        for_each = !each.value["is_host_header_condition_enabled"] ? [] : [true]
        content {
          values = lookup(each.value["conditions"], "host_header")
        }
      }

      dynamic "http_header" {
        for_each = !each.value["is_http_header_condition_enabled"] ? [] : [true]
        content {
          http_header_name = lookup(each.value["conditions"]["http_header"], "header")
          values           = lookup(each.value["conditions"]["http_header"], "values")
        }
      }

      dynamic "path_pattern" {
        for_each = !each.value["is_path_pattern_condition_enabled"] ? [] : [true]
        content {
          values = lookup(each.value["conditions"], "path_pattern")
        }
      }
    }
  }
}
