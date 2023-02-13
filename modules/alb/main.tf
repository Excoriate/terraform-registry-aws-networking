resource "aws_lb" "this" {
  for_each                         = local.alb_config_to_create
  name                             = each.value["name"]
  internal                         = each.value["internal"]
  load_balancer_type               = each.value["load_balancer_type"]
  security_groups                  = each.value["security_groups"]
  subnets                          = each.value["subnets"]
  enable_cross_zone_load_balancing = each.value["enable_cross_zone_load_balancing"]
  enable_deletion_protection       = each.value["enable_deletion_protection"]
  enable_http2                     = each.value["enable_http2"]

  dynamic "access_logs" {
    for_each = each.value["access_logs"]
    iterator = config
    content {
      bucket  = config.value["bucket"]
      prefix  = config.value["prefix"]
      enabled = config.value["enabled"]
    }
  }

  tags = var.tags
}
