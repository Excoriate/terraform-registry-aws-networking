module "main_module" {
  source     = "../../../modules/security-group-rules"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  security_group_config    = var.security_group_config
  security_group_rules     = var.security_group_rules
  security_group_rules_ooo = var.security_group_rules_ooo
}
