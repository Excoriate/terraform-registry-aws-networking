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
output "listener_rule_fixed_response" {
  value       = module.main_module.listener_rule_fixed_response
  description = "The listener rule for fixed response."
}

output "listener_rule_redirect" {
  value       = module.main_module.listener_rule_redirect
  description = "The listener rule for redirect."
}

output "listener_rule_host_header" {
  value       = module.main_module.listener_rule_host_header
  description = "The listener rule for the forward action"
}

output "listener_parent_configuration" {
  value       = module.main_module.listener_parent_configuration
  description = "The listener parent configuration."
}
