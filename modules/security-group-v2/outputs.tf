output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

###################################
# Module-Specific Outputs 🚀
# ----------------------------------------------------
#
# These outputs are specific to the functionality provided by this module.
# They offer insights and access points into the resources created or managed by this module.
#
# (Add your module-specific outputs here, with a brief description for each)
#
###################################

output "security_group_id" {
  value       = local.is_enabled ? aws_security_group.this[try(keys(local.sg_groups_to_create)[0], "")].id : ""
  description = "The ID of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_arn" {
  value       = local.is_enabled ? aws_security_group.this[try(keys(local.sg_groups_to_create)[0], "")].arn : ""
  description = "The ARN of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_name" {
  value       = local.is_enabled ? aws_security_group.this[try(keys(local.sg_groups_to_create)[0], "")].name : ""
  description = "The name of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_description" {
  value       = local.is_enabled ? aws_security_group.this[try(keys(local.sg_groups_to_create)[0], "")].description : ""
  description = "The description of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}

output "security_group_vpc_id" {
  value       = local.is_enabled ? aws_security_group.this[try(keys(local.sg_groups_to_create)[0], "")].vpc_id : ""
  description = "The VPC ID associated with the security group created by the module. Returns an empty string if the module is not enabled or no security group is created."
}
