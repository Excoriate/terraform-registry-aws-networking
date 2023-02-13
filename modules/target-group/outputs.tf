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
output "target_group_alb_id" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.id
  ]
  description = "The ID of the target group."
}

output "target_group_alb_arn" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.arn
  ]
  description = "The ARN of the target group."
}

output "target_group_alb_arn_suffix" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.arn_suffix
  ]
  description = "The ARN suffix for use with CloudWatch Metrics."
}

output "target_group_alb_name" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.name
  ]
  description = "The name of the target group."
}

output "target_group_alb_port" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.port
  ]
  description = "The port on which the targets are listening."
}

output "target_group_alb_protocol" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.protocol
  ]
  description = "The protocol to use for routing traffic to the targets."
}

output "target_group_alb_vpc_id" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.vpc_id
  ]
  description = "The ID of the VPC for the targets."
}

output "target_group_alb_health_check" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.health_check
  ]
  description = "A health check block."
}

output "target_group_alb_stickiness" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.stickiness
  ]
  description = "A stickiness block."
}

output "target_group_alb_target_type" {
  value = [
    for tg in aws_lb_target_group.alb_tg : tg.target_type
  ]
  description = "The type of target that you must specify when registering targets with this target group."
}
