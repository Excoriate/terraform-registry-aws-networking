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
output "feature_flag_hosted_zone_stand_alone_enabled" {
  value       = module.main_module.feature_flag_hosted_zone_stand_alone_enabled
  description = "Whether the feature flag for the stand alone hosted zone is enabled or not."
}

output "feature_flag_hosted_zone_subdomains_parent_enabled" {
  value       = module.main_module.feature_flag_hosted_zone_subdomains_parent_enabled
  description = "Whether the feature flag for the stand alone hosted zone is enabled or not."
}

output "feature_flag_hosted_zone_subdomains_childs_enabled" {
  value       = module.main_module.feature_flag_hosted_zone_subdomains_childs_enabled
  description = "Whether the feature flag for the stand alone hosted zone is enabled or not."
}

output "hosted_zone_stand_alone_id" {
  value       = module.main_module.hosted_zone_stand_alone_id
  description = "The ID of the stand alone hosted zone."
}

output "hosted_zone_stand_alone_name" {
  value       = module.main_module.hosted_zone_stand_alone_name
  description = "The Name of the stand alone hosted zone."
}

output "hosted_zone_stand_alone_name_servers" {
  value       = module.main_module.hosted_zone_stand_alone_name_servers
  description = "The name servers of the stand alone hosted zone."
}

output "hosted_zone_subdomains_parent_id" {
  value       = module.main_module.hosted_zone_subdomains_parent_id
  description = "The ID of the parent hosted zone for the subdomains."
}

output "hosted_zone_subdomains_parent_name" {
  value       = module.main_module.hosted_zone_subdomains_parent_name
  description = "The Name of the parent hosted zone for the subdomains."
}

output "hosted_zone_subdomains_parent_name_servers" {
  value       = module.main_module.hosted_zone_subdomains_parent_name_servers
  description = "The name servers of the parent hosted zone for the subdomains."
}

output "hosted_zone_subdomains_childs_id" {
  value       = module.main_module.hosted_zone_subdomains_childs_id
  description = "The ID of the child hosted zone for the subdomains."
}

output "hosted_zone_subdomains_childs_name" {
  value       = module.main_module.hosted_zone_subdomains_childs_name
  description = "The Name of the child hosted zone for the subdomains."
}

output "hosted_zone_subdomains_childs_name_servers" {
  value       = module.main_module.hosted_zone_subdomains_childs_name_servers
  description = "The name servers of the child hosted zone for the subdomains."
}
