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
output "sg_id" {
  value       = module.main_module.sg_id
  description = "The security groups that this module creates."
}

output "sg_arn" {
  value       = module.main_module.sg_arn
  description = "The ARNs of the security groups that this module creates."
}

output "sg_name" {
  value       = module.main_module.sg_name
  description = "The names of the security groups that this module creates."
}

output "sg_description" {
  value       = module.main_module.sg_description
  description = "The descriptions of the security groups that this module creates."
}

output "sg_vpc_id" {
  value       = module.main_module.sg_vpc_id
  description = "The VPC IDs of the security groups that this module creates."
}
