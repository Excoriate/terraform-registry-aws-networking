output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = module.main_module.aws_region_for_deploy_this
  description = "The AWS region where the module is deployed."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "aws_region_for_deploy" {
  value       = module.main_module.aws_region_for_deploy
  description = "The AWS region where the module is deployed."
}

output "acm_certificate_id" {
  value       = module.main_module.acm_certificate_id
  description = "The ID of the ACM certificate."
}

output "acm_certificate_arn" {
  value       = module.main_module.acm_certificate_arn
  description = "The ARN of the ACM certificate."
}

output "acm_certificate_domain_name" {
  value       = module.main_module.acm_certificate_domain_name
  description = "The domain name for the certificate."
}

output "acm_certificate_status" {
  value       = module.main_module.acm_certificate_status
  description = "The status of the certificate."
}

output "acm_zone_by_zone_id" {
  value       = module.main_module.acm_zone_by_zone_id
  description = "The ID of the hosted zone, when the zone_id lookup option is enabled."
}

output "acm_zone_by_zone_name" {
  value       = module.main_module.acm_zone_by_zone_name
  description = "The name of the hosted zone, when the zone_name lookup option is enabled."
}
