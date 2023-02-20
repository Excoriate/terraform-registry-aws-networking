module "main_module" {
  source     = "../../../modules/route53-dns-records"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  record_type_alias_config = [
    {
      name    = "www"
      zone_id = "Z2FDTNDATAQYW2"
      alias_target_config = {
        target_zone_id             = "Z2FDTNDATAQYW2"
        target_dns_name            = "dualstack.elb.amazonaws.com"
        target_enable_health_check = true
      }
    }
  ]
}
