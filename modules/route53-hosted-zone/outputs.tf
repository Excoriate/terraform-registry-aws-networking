output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "feature_flag_hosted_zone_stand_alone_enabled" {
  value       = local.is_hosted_zone_stand_alone_enabled
  description = "Whether the feature flag for the stand alone hosted zone is enabled or not."
}

output "feature_flag_hosted_zone_subdomains_parent_enabled" {
  value       = local.is_hosted_zone_subdomains_parent_set
  description = "Whether the feature flag for the stand alone hosted zone is enabled or not."
}

output "feature_flag_hosted_zone_subdomains_childs_enabled" {
  value       = local.is_hosted_zone_subdomains_childs_set
  description = "Whether the feature flag for the stand alone hosted zone is enabled or not."
}

output "hosted_zone_stand_alone_id" {
  value       = [for z in aws_route53_zone.hosted_zone : z.zone_id]
  description = "The ID of the stand alone hosted zone."
}

output "hosted_zone_stand_alone_name" {
  value       = [for z in aws_route53_zone.hosted_zone : z.name]
  description = "The Name of the stand alone hosted zone."
}

output "hosted_zone_stand_alone_name_servers" {
  value       = [for z in aws_route53_zone.hosted_zone : z.name_servers]
  description = "The name servers of the stand alone hosted zone."
}

output "hosted_zone_subdomains_parent_id" {
  value       = [for z in aws_route53_zone.hosted_zone_subdomain_parent : z.zone_id]
  description = "The ID of the parent hosted zone for the subdomains."
}

output "hosted_zone_subdomains_parent_name" {
  value       = [for z in aws_route53_zone.hosted_zone_subdomain_parent : z.name]
  description = "The Name of the parent hosted zone for the subdomains."
}

output "hosted_zone_subdomains_parent_name_servers" {
  value       = [for z in aws_route53_zone.hosted_zone_subdomain_parent : z.name_servers]
  description = "The name servers of the parent hosted zone for the subdomains."
}

output "hosted_zone_subdomains_childs_id" {
  value       = [for z in aws_route53_zone.hosted_zone_subdomain_child : z.zone_id]
  description = "The ID of the child hosted zone for the subdomains."
}

output "hosted_zone_subdomains_childs_name" {
  value       = [for z in aws_route53_zone.hosted_zone_subdomain_child : z.name]
  description = "The Name of the child hosted zone for the subdomains."
}

output "hosted_zone_subdomains_childs_name_servers" {
  value       = [for z in aws_route53_zone.hosted_zone_subdomain_child : z.name_servers]
  description = "The name servers of the child hosted zone for the subdomains."
}
