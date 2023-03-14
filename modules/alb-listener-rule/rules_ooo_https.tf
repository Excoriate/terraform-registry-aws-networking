resource "aws_lb_listener_rule" "ooo_redirect_https_by_host_header" {
  for_each     = { for k, v in local.action_redirect_https_create : k => v if v["is_host_header_condition_enabled"] }
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

  condition {
    host_header {
      values = lookup(each.value["conditions"], "host_header")
    }
  }
}

resource "aws_lb_listener_rule" "ooo_redirect_https_by_http_headers" {
  for_each     = { for k, v in local.action_redirect_https_create : k => v if v["is_http_header_condition_enabled"] }
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

  condition {
    http_header {
      http_header_name = lookup(each.value["conditions"]["http_header"], "header")
      values           = lookup(each.value["conditions"]["http_header"], "values")
    }
  }
}

resource "aws_lb_listener_rule" "ooo_redirect_https_by_path_pattern" {
  for_each     = { for k, v in local.action_redirect_https_create : k => v if v["is_path_pattern_condition_enabled"] }
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

  condition {
    path_pattern {
      values = lookup(each.value["conditions"], "path_pattern")
    }
  }
}


resource "aws_lb_listener_rule" "ooo_redirect_https_by_http_request_method" {
  for_each     = { for k, v in local.action_redirect_https_create : k => v if v["is_http_request_method_condition_enabled"] }
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

  condition {
    http_request_method {
      values = lookup(each.value["conditions"], "http_request_method")
    }
  }
}
