<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Security Group Attacher
## Description
These are OOO set of rules, that are enabled by the feature flags included in the 'var.security\_group\_rules\_ooo' configuration.
Rules: HTTP, HTTPS, ICMP, SSH, RDP, PosgreSQL, and MySQ
This module aims to attach security group rules into an existing security group, by its name or id.
* 🚀 Add security group rules.
* 🚀 Add through feature-flags built-in security group rules for common use-cases.
This module lookup for the `sg` either by its name or id. Ensure that while it's being used, these parameters are valid and refer to an actual security group.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/security-group-rules"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  security_group_config    = var.security_group_config
  security_group_rules     = var.security_group_rules
  security_group_rules_ooo = var.security_group_rules_ooo
}
```

```hcl
aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name    = "sg-1"
    sg_name = "stack-test-alb-sg"
  }
]
```

```hcl
aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name    = "sg-1"
    sg_name = "stack-test-alb-sg"
  }
]

security_group_rules = [
  {
    name      = "sg-1"
    sg_name   = "stack-test-alb-sg"
    from_port = 2221
    to_port   = 2221
  }
]
```

```hcl
aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name    = "sg-1"
    sg_name = "stack-test-alb-sg"
  }
]

security_group_rules_ooo = [
  {
    name                     = "sg-1"
    sg_name                  = "stack-test-alb-sg"
    enable_inbound_all_http  = true
    enable_outbound_all_http = true
  }
]
```

For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
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
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.58.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group_rule.custom_cidr_based](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.custom_sg_based](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_http_from_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_https_from_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_traffic_from_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_custom_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_custom_port_from_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_http_to_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_https_to_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_traffic_to_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_custom_port](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_custom_port_to_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group.sg_by_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [aws_security_group.sg_by_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | A list of objects that contains the configuration for the security groups. This object aims<br>to configure a lookup operation for an existing security group, either looking up by<br>its 'id' or by its 'name'. The following attributes are supported:<br>- name: Friendly name for each resource. Act as a terraform identifier.<br>- sg\_name: The name of the security group.<br>- sg\_id: The id of the security group.<br>  If the sg\_id is passed, it'll take precedence over the sg\_name. | <pre>list(object({<br>    // Identifiers<br>    name    = string                 // Friendly name.<br>    sg_name = string                 // Security group name to check.<br>    sg_id   = optional(string, null) // Security group id to check.<br>  }))</pre> | `null` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of objects that contains the configuration for the security groups.<br>If set, it'll relate the sg\_name with the 'name' attribute passed into the<br>variable 'security\_group\_config'. The following attributes are supported:<br>- sg\_parent: The name of the security group.<br>- type: The type of the security group rule. Valid values are: ingress, egress.<br>- from\_port: The start port of the security group rule.<br>- to\_port: The end port of the security group rule.<br>- protocol: The protocol of the security group rule. Valid values are: tcp, udp, icmp, all.<br>- cidr\_blocks: The CIDR blocks to allow access from.<br>- ipv6\_cidr\_blocks: The IPv6 CIDR blocks to allow access from.<br>- prefix\_list\_ids: The prefix list IDs to allow access from.<br>- self: Whether to allow access from the security group itself.<br>- description: The description of the security group rule.<br>- source\_security\_group\_id: The ID of the security group to allow access from. | <pre>list(object({<br>    name                     = string<br>    sg_name                  = string                 // Security group name to check.<br>    sg_id                    = optional(string, null) // Security group id to check.<br>    type                     = optional(string, "ingress")<br>    from_port                = number<br>    to_port                  = number<br>    protocol                 = optional(string, "tcp")<br>    cidr_blocks              = optional(list(string), null)<br>    ipv6_cidr_blocks         = optional(list(string), null)<br>    prefix_list_ids          = optional(list(string), null)<br>    self                     = optional(bool, false)<br>    description              = optional(string, "No description was set for this security group rule")<br>    source_security_group_id = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_security_group_rules_ooo"></a> [security\_group\_rules\_ooo](#input\_security\_group\_rules\_ooo) | A set of out-of-the-box rules to be applied to the security group. The following attributes are supported:<br>- name: Friendly name for each resource. Act as a terraform identifier.<br>- sg\_name: The name of the security group.<br>- sg\_id: The id of the security group.<br>- source\_security\_group\_id: The ID of the security group to allow access from.<br>- enable\_inbound\_all\_traffic: Whether to allow all inbound traffic.<br>- enable\_inbound\_all\_http: Whether to allow all inbound HTTP traffic.<br>- enable\_inbound\_all\_https: Whether to allow all inbound HTTPS traffic.<br>- enable\_inbound\_all\_https\_from\_sg: Whether to allow all inbound HTTPS traffic from the security group itself.<br>- enable\_inbound\_all\_http\_from\_sg: Whether to allow all inbound HTTP traffic from the security group itself.<br>- enable\_inbound\_all\_traffic\_from\_sg: Whether to allow all inbound traffic from the security group itself.<br>- enable\_outbound\_all\_traffic: Whether to allow all outbound traffic.<br>- enable\_outbound\_all\_traffic\_to\_sg: Whether to allow all outbound traffic to the security group itself.<br>- enable\_outbound\_all\_http: Whether to allow all outbound HTTP traffic.<br>- enable\_outbound\_all\_http\_to\_sg: Whether to allow all outbound HTTP traffic to the security group itself.<br>- enable\_outbound\_all\_https: Whether to allow all outbound HTTPS traffic.<br>- enable\_outbound\_all\_https\_to\_sg: Whether to allow all outbound HTTPS traffic to the security group itself.<br>- cidr\_blocks: The CIDR blocks to allow access from.<br>- custom\_port: The custom port to allow access from. | <pre>list(object({<br>    // Identifiers<br>    name                               = string                 // Friendly name.<br>    sg_name                            = string                 // Security group name to check.<br>    sg_id                              = optional(string, null) // Security group id to check.<br>    source_security_group_id           = optional(string, null)<br>    enable_inbound_all_traffic         = optional(bool, false)<br>    enable_inbound_all_http            = optional(bool, false)<br>    enable_inbound_all_https           = optional(bool, false)<br>    enable_inbound_all_https_from_sg   = optional(bool, false)<br>    enable_inbound_all_http_from_sg    = optional(bool, false)<br>    enable_inbound_all_traffic_from_sg = optional(bool, false)<br>    enable_outbound_all_traffic        = optional(bool, false)<br>    enable_outbound_all_traffic_to_sg  = optional(bool, false)<br>    enable_outbound_all_http           = optional(bool, false)<br>    enable_outbound_all_http_to_sg     = optional(bool, false)<br>    enable_outbound_all_https          = optional(bool, false)<br>    enable_outbound_all_https_to_sg    = optional(bool, false)<br>    cidr_blocks                        = optional(list(string), null)<br>    custom_port                        = optional(number, null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_sg"></a> [sg](#output\_sg) | The name of the security group. |
| <a name="output_sg_arn"></a> [sg\_arn](#output\_sg\_arn) | The ARN of the security group. |
| <a name="output_sg_config_input"></a> [sg\_config\_input](#output\_sg\_config\_input) | The configuration of the security group. |
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | The ID of the security group. |
| <a name="output_sg_name"></a> [sg\_name](#output\_sg\_name) | The name of the security group. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
