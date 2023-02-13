module "main_module" {
  source     = "../../../modules/alb"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  alb_config = var.alb_config
}
