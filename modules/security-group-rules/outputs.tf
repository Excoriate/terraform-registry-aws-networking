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
output "sg" {
  value       = length([for sg in data.aws_security_group.sg_by_name : sg]) > 0 ? [for sg in data.aws_security_group.sg_by_name : sg] : [for sg in data.aws_security_group.sg_by_id : sg]
  description = "The name of the security group."
}


output "sg_name" {
  value       = length([for sg in data.aws_security_group.sg_by_name : sg.name]) > 0 ? [for sg in data.aws_security_group.sg_by_name : sg.name] : [for sg in data.aws_security_group.sg_by_id : sg.name]
  description = "The name of the security group."
}

output "sg_id" {
  value       = length([for sg in data.aws_security_group.sg_by_name : sg.id]) > 0 ? [for sg in data.aws_security_group.sg_by_name : sg.id] : [for sg in data.aws_security_group.sg_by_id : sg.id]
  description = "The ID of the security group."
}

output "sg_arn" {
  value       = length([for sg in data.aws_security_group.sg_by_name : sg.arn]) > 0 ? [for sg in data.aws_security_group.sg_by_name : sg.arn] : [for sg in data.aws_security_group.sg_by_id : sg.arn]
  description = "The ARN of the security group."
}

output "sg_config_input" {
  value       = local.sg_create
  description = "The configuration of the security group."
}
