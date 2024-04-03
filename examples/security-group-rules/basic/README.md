<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/security-group-rules | n/a |

## Resources

No resources.

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
| <a name="output_sg"></a> [sg](#output\_sg) | The security group. |
| <a name="output_sg_arn"></a> [sg\_arn](#output\_sg\_arn) | The ARN of the security group. |
| <a name="output_sg_config_input"></a> [sg\_config\_input](#output\_sg\_config\_input) | The configuration of the security group. |
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | The ID of the security group. |
| <a name="output_sg_name"></a> [sg\_name](#output\_sg\_name) | The name of the security group. |
<!-- END_TF_DOCS -->
