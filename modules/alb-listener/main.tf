resource "aws_lb_listener" "this" {
  for_each          = local.alb_listener_to_create
  load_balancer_arn = each.value["alb_arn"]
  port              = each.value["port"]
  protocol          = each.value["protocol"]
  ssl_policy        = each.value["ssl_policy"]
  certificate_arn   = each.value["certificate_arn"]

  dynamic "default_action" {
    for_each = each.value["default_action"]
    iterator = config
    content {
      type             = config.value["type"]
      target_group_arn = config.value["target_group_arn"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_listener" "http_ooo" {
  for_each          = local.alb_listeners_http_to_create
  load_balancer_arn = each.value["alb_arn"]
  port              = each.value["port"]
  protocol          = each.value["protocol"]

  default_action {
    type             = each.value["default_action"]["type"]
    target_group_arn = each.value["default_action"]["target_group_arn"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb_listener" "https_ooo" {
  for_each          = local.alb_listeners_https_to_create
  load_balancer_arn = each.value["alb_arn"]
  port              = each.value["port"]
  protocol          = each.value["protocol"]
  ssl_policy        = each.value["ssl_policy"]
  certificate_arn   = each.value["certificate_arn"]

  default_action {
    type             = each.value["default_action"]["type"]
    target_group_arn = each.value["default_action"]["target_group_arn"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
