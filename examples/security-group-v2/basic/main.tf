module "main_module" {
  source                   = "../../../modules/security-group-v2"
  is_enabled               = var.is_enabled
}