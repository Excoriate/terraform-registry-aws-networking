module "main_module" {
  source                          = "../../../modules/security-group-v2"
  is_enabled                      = var.is_enabled
  security_group_config           = var.security_group_config
  rds_ingress_security_group_rule = var.rds_ingress_security_group_rule
}
