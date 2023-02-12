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
output "sg_id" {
  value       = [for sg in aws_security_group.this : sg.id]
  description = "The security groups that this module creates."
}

output "sg_arn" {
  value       = [for sg in aws_security_group.this : sg.arn]
  description = "The ARNs of the security groups that this module creates."
}

output "sg_name" {
  value       = [for sg in aws_security_group.this : sg.name]
  description = "The names of the security groups that this module creates."
}

output "sg_description" {
  value       = [for sg in aws_security_group.this : sg.description]
  description = "The descriptions of the security groups that this module creates."
}

output "sg_vpc_id" {
  value       = [for sg in aws_security_group.this : sg.vpc_id]
  description = "The VPC IDs of the security groups that this module creates."
}
