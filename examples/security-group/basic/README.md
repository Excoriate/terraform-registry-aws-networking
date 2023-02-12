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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/security-group | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Enable or disable the module | `bool` | n/a | yes |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | A list of objects that contains the configuration for the security groups.<br>This configuration includes the main configuration for the security group. The following<br>attributes are supported:<br>- name: The name of the security group.<br>- description: The description of the security group.<br>- vpc\_id: The VPC ID to create the security group in. | <pre>list(object({<br>    name        = string<br>    description = optional(string, null)<br>    vpc_id      = string<br>  }))</pre> | `null` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of objects that contains the configuration for the security groups.<br>If set, it'll relate the sg\_name with the 'name' attribute passed into the<br>variable 'security\_group\_config'. The following attributes are supported:<br>- sg\_parent: The name of the security group.<br>- sg\_rules: An object that contains the configuration for the security group rules. | <pre>list(object({<br>    sg_parent        = string<br>    type             = string<br>    from_port        = number<br>    to_port          = number<br>    protocol         = string<br>    cidr_blocks      = optional(list(string), null)<br>    ipv6_cidr_blocks = optional(list(string), null)<br>    prefix_list_ids  = optional(list(string), null)<br>    self             = optional(bool, false)<br>    description      = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_security_group_rules_ooo"></a> [security\_group\_rules\_ooo](#input\_security\_group\_rules\_ooo) | A list of objects that contains the configuration for the security groups, and that normally<br>used in the context of ALB, testing traffic for ICMP packages, and other common use-cases<br>It can be used as an alternative of the values that are set in the variable 'security\_group\_rules'.<br>If set, it'll relate the sg\_name with the 'name' attribute passed into the<br>variable 'security\_group\_config'. The following attributes are supported:<br>- sg\_parent: The name of the security group.<br>- enable\_inbound\_http: Whether to enable inbound HTTP traffic or not.<br>- enable\_inbound\_https: Whether to enable inbound HTTPS traffic or not.<br>- enable\_inbound\_ssh: Whether to enable inbound SSH traffic or not.<br>- enable\_inbound\_icmp: Whether to enable inbound ICMP traffic or not. | <pre>list(object({<br>    sg_parent            = string<br>    enable_inbound_http  = optional(bool, false)<br>    enable_inbound_https = optional(bool, false)<br>    enable_inbound_ssh   = optional(bool, false)<br>    enable_inbound_icmp  = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_vpc_lookup_config"></a> [vpc\_lookup\_config](#input\_vpc\_lookup\_config) | This object works in ocnjunction with the variable 'security\_group\_config' to<br>lookup the VPC ID to create the security group in. The following attributes are supported:<br>- vpc\_name: The name of the VPC to lookup.<br>- is\_default\_vpc\_enabled: Whether to lookup the default VPC or not. | <pre>object({<br>    vpc_name               = optional(string, null)<br>    is_default_vpc_enabled = optional(bool, false)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_sg_arn"></a> [sg\_arn](#output\_sg\_arn) | The ARNs of the security groups that this module creates. |
| <a name="output_sg_description"></a> [sg\_description](#output\_sg\_description) | The descriptions of the security groups that this module creates. |
| <a name="output_sg_id"></a> [sg\_id](#output\_sg\_id) | The security groups that this module creates. |
| <a name="output_sg_name"></a> [sg\_name](#output\_sg\_name) | The names of the security groups that this module creates. |
| <a name="output_sg_vpc_id"></a> [sg\_vpc\_id](#output\_sg\_vpc\_id) | The VPC IDs of the security groups that this module creates. |
<!-- END_TF_DOCS -->
