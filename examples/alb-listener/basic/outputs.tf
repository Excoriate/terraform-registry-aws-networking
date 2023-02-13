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
output "alb_listener_id" {
  value       = module.main_module.alb_listener_id
  description = "The ID of the ALB listener."
}

output "alb_listener_arn" {
  value       = module.main_module.alb_listener_arn
  description = "The ARN of the ALB listener."
}

output "alb_listener_ssl_policy" {
  value       = module.main_module.alb_listener_ssl_policy
  description = "The SSL policy of the ALB listener."
}
