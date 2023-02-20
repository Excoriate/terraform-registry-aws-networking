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
output "dns_alias_id" {
  value       = module.main_module.dns_alias_id
  description = "The ID of the DNS alias record."
}

output "dns_alias_name" {
  value       = module.main_module.dns_alias_name
  description = "The name of the DNS alias record."
}

output "dns_alias_zone_id" {
  value       = module.main_module.dns_alias_zone_id
  description = "The zone ID of the DNS alias record."
}

output "dns_alias_fqdn" {
  value       = module.main_module.dns_alias_fqdn
  description = "The FQDN of the DNS alias record."
}

output "dns_alias_set_identifier" {
  value       = module.main_module.dns_alias_set_identifier
  description = "The set identifier of the DNS alias record."
}
