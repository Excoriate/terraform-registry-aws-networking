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
output "vpc_data" {
  value       = module.main_module.vpc_data
  description = "The VPC data."
}

output "subnet_private_data" {
  value       = module.main_module.subnet_private_data
  description = "The private subnet data."
}

output "subnet_public_data" {
  value       = module.main_module.subnet_public_data
  description = "The public subnet data."
}

output "subnet_all" {
  value       = module.main_module.subnet_all
  description = "The all subnet data."
}

output "subnet_all_ids" {
  value       = module.main_module.subnet_all_ids
  description = "All subnet ids"
}
