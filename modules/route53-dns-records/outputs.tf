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
output "dns_alias_id" {
  value       = [for dns_alias in aws_route53_record.alias : dns_alias.id]
  description = "The ID of the DNS alias record."
}

output "dns_alias_name" {
  value       = [for dns_alias in aws_route53_record.alias : dns_alias.name]
  description = "The name of the DNS alias record."
}

output "dns_alias_zone_id" {
  value       = [for dns_alias in aws_route53_record.alias : dns_alias.zone_id]
  description = "The zone ID of the DNS alias record."
}

output "dns_alias_fqdn" {
  value       = [for dns_alias in aws_route53_record.alias : dns_alias.fqdn]
  description = "The FQDN of the DNS alias record."
}

output "dns_alias_set_identifier" {
  value       = [for dns_alias in aws_route53_record.alias : dns_alias.set_identifier]
  description = "The set identifier of the DNS alias record."
}
