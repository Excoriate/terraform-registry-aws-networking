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
output "sg" {
  value       = module.main_module.sg
  description = "The security group."
}

output "sg_name" {
  value       = module.main_module.sg_name
  description = "The name of the security group."
}

output "sg_id" {
  value       = module.main_module.sg_id
  description = "The ID of the security group."
}

output "sg_arn" {
  value       = module.main_module.sg_arn
  description = "The ARN of the security group."
}

output "sg_config_input" {
  value       = module.main_module.sg_config_input
  description = "The configuration of the security group."
}
