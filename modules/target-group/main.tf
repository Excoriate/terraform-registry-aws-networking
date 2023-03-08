resource "aws_lb_target_group" "alb_tg" {
  for_each                      = local.target_group_alb_to_create
  name                          = each.value["name"]
  port                          = each.value["port"]
  protocol                      = each.value["protocol"]
  protocol_version              = each.value["protocol_version"]
  slow_start                    = each.value["slow_start"]
  target_type                   = each.value["target_type"]
  vpc_id                        = each.value["vpc_id"]
  deregistration_delay          = each.value["deregistration_delay"]
  load_balancing_algorithm_type = each.value["load_balancing_algorithm_type"]

  dynamic "health_check" {
    for_each = each.value["health_check"] == null ? [] : [each.value["health_check"]]
    content {
      enabled             = health_check.value["enabled"]
      healthy_threshold   = health_check.value["healthy_threshold"]
      interval            = health_check.value["interval"]
      matcher             = health_check.value["matcher"]
      path                = health_check.value["path"]
      port                = health_check.value["port"]
      protocol            = health_check.value["protocol"]
      timeout             = health_check.value["timeout"]
      unhealthy_threshold = health_check.value["unhealthy_threshold"]
    }
  }

  dynamic "stickiness" {
    for_each = each.value["stickiness"] == null ? [] : [each.value["stickiness"]]
    content {
      cookie_duration = stickiness.value["cookie_duration"]
      enabled         = stickiness.value["enabled"]
      type            = stickiness.value["type"]
    }
  }
  tags = var.tags
}
