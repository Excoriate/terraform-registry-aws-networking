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
output "alb_arn" {
  value       = module.main_module.alb_arn
  description = "The ARN of the ALB."
}

output "alb_arn_suffix" {
  value       = module.main_module.alb_arn_suffix
  description = "The ARN suffix for use with CloudWatch Metrics."
}

output "alb_dns_name" {
  value       = module.main_module.alb_dns_name
  description = "The DNS name of the ALB."
}

output "alb_zone_id" {
  value       = module.main_module.alb_zone_id
  description = "The canonical hosted zone ID of the ALB (to be used in a Route 53 Alias record)."
}

output "alb_name" {
  value       = module.main_module.alb_name
  description = "The name of the ALB."
}
