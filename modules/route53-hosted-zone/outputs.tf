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
output "hosted_zone_name" {
  value       = [for z in aws_route53_zone.this : z.name]
  description = "The name of the hosted zone."
}

output "hosted_zone_id" {
  value       = [for z in aws_route53_zone.this : z.zone_id]
  description = "The ID of the hosted zone."
}

output "hosted_zone_name_servers" {
  value       = [for z in aws_route53_zone.this : z.name_servers]
  description = "A list of name servers in associated (or default) delegation set."
}
