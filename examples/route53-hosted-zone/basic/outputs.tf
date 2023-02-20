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
output "hosted_zone_name" {
  value       = module.main_module.hosted_zone_name
  description = "The name of the hosted zone."
}

output "hosted_zone_id" {
  value       = module.main_module.hosted_zone_id
  description = "The ID of the hosted zone."
}

output "hosted_zone_name_servers" {
  value       = module.main_module.hosted_zone_name_servers
  description = "A list of name servers in associated (or default) delegation set."
}
