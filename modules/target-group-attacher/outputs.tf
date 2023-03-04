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
output "attachment_id" {
  value       = [for l in aws_lb_target_group_attachment.this : l.id]
  description = "Attachment ID"
}

output "target_group_arn" {
  value       = [for l in aws_lb_target_group_attachment.this : l.target_group_arn]
  description = "Target group ARN"
}

output "target_id" {
  value       = [for l in aws_lb_target_group_attachment.this : l.target_id]
  description = "Target ID"
}

output "target_port" {
  value       = [for l in aws_lb_target_group_attachment.this : l.port]
  description = "Target port"
}

output "target_availability_zone" {
  value       = [for l in aws_lb_target_group_attachment.this : l.availability_zone]
  description = "Target availability zone"
}
