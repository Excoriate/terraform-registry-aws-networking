module "main_module" {
  source     = "../../../modules/lookup-data"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  vpc_data = var.vpc_data
  dns_data = var.dns_data
}
