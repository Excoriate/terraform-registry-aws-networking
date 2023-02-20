module "main_module" {
  source     = "../../../modules/acm-certificate"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  acm_certificate_config = var.acm_certificate_config
}
