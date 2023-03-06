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
output "listener_rule_fixed_response" {
  value       = [for rule in aws_lb_listener_rule.rule_fixed_response : rule]
  description = "The listener rule for fixed response."
}

output "listener_rule_redirect" {
  value       = [for rule in aws_lb_listener_rule.rule_redirection : rule]
  description = "The listener rule for redirect."
}

output "listener_rule_host_header" {
  value       = [for rule in aws_lb_listener_rule.rule_forward : rule]
  description = "The listener rule for the forward action"
}

output "listener_parent_configuration" {
  value       = !local.is_enabled ? null : local.parent_config_to_create
  description = "The listener parent configuration."
}
