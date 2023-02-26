module "main_module" {
  source     = "../../../modules/route53-hosted-zone"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  hosted_zone_stand_alone       = var.hosted_zone_stand_alone
  hosted_zone_subdomains_parent = var.hosted_zone_subdomains_parent
  hosted_zone_subdomains_childs = var.hosted_zone_subdomains_childs
}
