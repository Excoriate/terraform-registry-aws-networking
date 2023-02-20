module "main_module" {
  source     = "../../../modules/route53-hosted-zone"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  hosted_zone_config     = var.hosted_zone_config
  hosted_zone_subdomains = var.hosted_zone_subdomains
}
