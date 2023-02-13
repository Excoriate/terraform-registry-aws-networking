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
output "alb_arn" {
  value       = [for alb in aws_lb.this : alb.arn]
  description = "The ARN of the ALB."
}

output "alb_arn_suffix" {
  value       = [for alb in aws_lb.this : alb.arn_suffix]
  description = "The ARN suffix for use with CloudWatch Metrics."
}

output "alb_dns_name" {
  value       = [for alb in aws_lb.this : alb.dns_name]
  description = "The DNS name of the ALB."
}

output "alb_zone_id" {
  value       = [for alb in aws_lb.this : alb.zone_id]
  description = "The canonical hosted zone ID of the ALB (to be used in a Route 53 Alias record)."
}
