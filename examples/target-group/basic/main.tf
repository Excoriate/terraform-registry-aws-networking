module "main_module" {
  source     = "../../../modules/target-group"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  target_group_config = var.target_group_config
}
