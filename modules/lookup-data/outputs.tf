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
output "vpc_data" {
  value       = data.aws_vpc.this
  description = "The VPC data."
}

output "subnet_private_data" {
  value       = data.aws_subnet_ids.subnets_private
  description = "The private subnet data."
}

output "subnet_public_data" {
  value       = data.aws_subnet_ids.subnets_public
  description = "The public subnet data."
}

output "subnet_all" {
  value       = data.aws_subnet.all_subnets
  description = "The all subnet data."
}

output "subnet_all_ids" {
  value       = data.aws_subnet_ids.all_subnet_ids
  description = "All subnet ids"
}

output "subnet_public_az_a_ids_data" {
  value       = data.aws_subnet_ids.subnets_public_by_az_1a
  description = "The public subnet ids data for AZ A."
}

output "subnet_public_az_a_data" {
  value       = data.aws_subnet.subnets_public_by_az_1a
  description = "The public subnet data for AZ A."
}

output "subnet_public_az_b_ids_data" {
  value       = data.aws_subnet_ids.subnets_public_by_az_1b
  description = "The public subnet ids data for AZ B."
}

output "subnet_public_az_b_data" {
  value       = data.aws_subnet.subnets_public_by_az_1b
  description = "The public subnet data for AZ B."
}

output "subnet_public_az_c_ids_data" {
  value       = data.aws_subnet_ids.subnets_public_by_az_1c
  description = "The public subnet ids data for AZ C."
}

output "subnet_public_az_c_data" {
  value       = data.aws_subnet.subnets_public_by_az_1c
  description = "The public subnet data for AZ C."
}
