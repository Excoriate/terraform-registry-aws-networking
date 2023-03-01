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
output "aws_region_for_deploy" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "acm_certificate_id" {
  value       = [for certificate in aws_acm_certificate.this : certificate.id]
  description = "The ID of the ACM certificate."
}

output "acm_certificate_arn" {
  value       = [for certificate in aws_acm_certificate.this : certificate.arn]
  description = "The ARN of the ACM certificate."
}

output "acm_certificate_domain_name" {
  value       = [for certificate in aws_acm_certificate.this : certificate.domain_name]
  description = "The domain name for the certificate."
}

output "acm_certificate_status" {
  value       = [for certificate in aws_acm_certificate.this : certificate.status]
  description = "The status of the certificate."
}

output "acm_zone_by_zone_id" {
  value       = [for zone in data.aws_route53_zone.lookup_for_zone_id : zone.id]
  description = "The ID of the hosted zone, when the zone_id lookup option is enabled."
}

output "acm_zone_by_zone_name" {
  value       = [for zone in data.aws_route53_zone.lookup_for_zone_name : zone.name]
  description = "The name of the hosted zone, when the zone_name lookup option is enabled."
}

output "feature_flags" {
  value = {
    is_validation_enabled  = local.is_certificate_validation_enabled
    is_enabled             = local.is_certificate_enabled
    acm_validation_object  = local.acm_validation_to_create
    acm_certificate_object = local.acm_cert_to_create
  }
}
