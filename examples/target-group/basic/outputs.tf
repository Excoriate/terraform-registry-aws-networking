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
output "target_group_alb_id" {
  value       = module.main_module.target_group_alb_id
  description = "The ID of the target group."
}

output "target_group_alb_arn" {
  value       = module.main_module.target_group_alb_arn
  description = "The ARN of the target group."
}

output "target_group_alb_arn_suffix" {
  value       = module.main_module.target_group_alb_arn_suffix
  description = "The ARN suffix for use with CloudWatch Metrics."
}

output "target_group_alb_name" {
  value       = module.main_module.target_group_alb_name
  description = "The name of the target group."
}

output "target_group_alb_port" {
  value       = module.main_module.target_group_alb_port
  description = "The port on which the targets are listening."
}

output "target_group_alb_protocol" {
  value       = module.main_module.target_group_alb_protocol
  description = "The protocol to use for routing traffic to the targets."
}

output "target_group_alb_vpc_id" {
  value       = module.main_module.target_group_alb_vpc_id
  description = "The ID of the VPC for the targets."
}

output "target_group_alb_health_check" {
  value       = module.main_module.target_group_alb_health_check
  description = "A health check block."
}

output "target_group_alb_stickiness" {
  value       = module.main_module.target_group_alb_stickiness
  description = "A stickiness block."
}

output "target_group_alb_target_type" {
  value       = module.main_module.target_group_alb_target_type
  description = "The type of target that you must specify when registering targets with this target group."
}
