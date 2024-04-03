output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

output "security_group_id" {
  value       = module.main_module.security_group_id
  description = "The ID of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_arn" {
  value       = module.main_module.security_group_arn
  description = "The ARN of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_name" {
  value       = module.main_module.security_group_name
  description = "The name of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_description" {
  value       = module.main_module.security_group_description
  description = "The description of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_vpc_id" {
  value       = module.main_module.security_group_vpc_id
  description = "The VPC ID associated with the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}
