module "main_module" {
  source     = "../../../modules/alb-listener"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  alb_listeners_config = var.alb_listeners_config
}
