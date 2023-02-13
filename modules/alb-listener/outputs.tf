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
output "alb_listener_id" {
  value       = [for l in aws_lb_listener.this : l.id]
  description = "The ID of the ALB listener."
}

output "alb_listener_arn" {
  value       = [for l in aws_lb_listener.this : l.arn]
  description = "The ARN of the ALB listener."
}

output "alb_listener_ssl_policy" {
  value       = [for l in aws_lb_listener.this : l.ssl_policy]
  description = "The SSL policy of the ALB listener."
}
