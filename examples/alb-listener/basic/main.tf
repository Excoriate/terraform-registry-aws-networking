module "main_module" {
  source     = "../../../modules/alb-listener"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  alb_listeners_config   = var.alb_listeners_config
  alb_listener_ooo_http  = var.alb_listener_ooo_http
  alb_listener_ooo_https = var.alb_listener_ooo_https
}
