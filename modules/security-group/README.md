<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Security Group Module
## Description

This module provides a way to create a security group with a set of rules.
* 🚀 A security group, with standard rules.
* 🚀 A security group, with a set of rules.
This module is also capable of looking up for the VPC id if it's not provided. If the variable `vpc_id` is not provided, the module will use the values passed into the input variable 'var.vpc_lookup_config' to look for either the default VPC, or a named VPC using the tag 'Name' as its search criteria. If the VPC is not found, the module will throw an error.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source                   = "../../../modules/security-group"
  is_enabled               = var.is_enabled
  aws_region               = var.aws_region
  security_group_config    = var.security_group_config
  vpc_lookup_config        = var.vpc_lookup_config
  security_group_rules     = var.security_group_rules
  security_group_rules_ooo = var.security_group_rules_ooo
}
```

An example of multiple security groups, created at once:
```hcl
aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name        = "firewall-test-1"
    description = "my sg that i am testing"
    vpc_id      = "vpc-1234567890"
  },
  {
    name        = "firewall-test-2"
    description = "Another security group"
    vpc_id      = "vpc-1234567890"
  }
]
```
An example of a security group that's created passing its VPC, as the default VPC:
```hcl
aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name        = "firewall-test-1"
    description = "my sg that i am testing"
    vpc_id      = "vpc-1234567890"
  }
]


vpc_lookup_config = {
  is_default_vpc_enabled = true
}
```
An example of a security group that's pointing or looking for a VPC with a specific name:
```hcl
aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name        = "firewall-test-1"
    description = "my sg that i am testing"
    vpc_id      = "vpc-1234567890"
  }
]


vpc_lookup_config = {
  vpc_name = "tsn-sandbox-us-east-1-network-core-cross-vpc-backbone"
}
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
output "sg_id" {
  value       = [for sg in aws_security_group.this : sg.id]
  description = "The security groups that this module creates."
}

output "sg_arn" {
  value       = [for sg in aws_security_group.this : sg.arn]
  description = "The ARNs of the security groups that this module creates."
}

output "sg_name" {
  value       = [for sg in aws_security_group.this : sg.name]
  description = "The names of the security groups that this module creates."
}

output "sg_description" {
  value       = [for sg in aws_security_group.this : sg.description]
  description = "The descriptions of the security groups that this module creates."
}

output "sg_vpc_id" {
  value       = [for sg in aws_security_group.this : sg.vpc_id]
  description = "The VPC IDs of the security groups that this module creates."
}
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.54.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.cidr_based_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_all_traffic_from_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_custom_port_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_custom_port_source_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_http_from_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_https_from_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_icmp_from_anywhere](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_icmp_from_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_mysq_from_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_rdp_from_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_inbound_ssh_from_anywhere](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_all_traffic_to_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_custom_port_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_custom_port_source_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_http_to_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ooo_outbound_https_to_source](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.self_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.source_sg_based_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc.named](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

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
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | A list of objects that contains the configuration for the security groups.<br>This configuration includes the main configuration for the security group. The following<br>attributes are supported:<br>- name: The name of the security group.<br>- description: The description of the security group.<br>- vpc\_id: The VPC ID to create the security group in. | <pre>list(object({<br>    name        = string<br>    description = optional(string, null)<br>    vpc_id      = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | A list of objects that contains the configuration for the security groups.<br>If set, it'll relate the sg\_name with the 'name' attribute passed into the<br>variable 'security\_group\_config'. The following attributes are supported:<br>- sg\_parent: The name of the security group.<br>- type: The type of the security group rule. Valid values are: ingress, egress.<br>- from\_port: The start port of the security group rule.<br>- to\_port: The end port of the security group rule.<br>- protocol: The protocol of the security group rule. Valid values are: tcp, udp, icmp, all.<br>- cidr\_blocks: The CIDR blocks to allow access from.<br>- ipv6\_cidr\_blocks: The IPv6 CIDR blocks to allow access from.<br>- prefix\_list\_ids: The prefix list IDs to allow access from.<br>- self: Whether to allow access from the security group itself.<br>- description: The description of the security group rule.<br>- source\_security\_group\_id: The ID of the security group to allow access from. | <pre>list(object({<br>    sg_parent                = string<br>    type                     = string<br>    from_port                = number<br>    to_port                  = number<br>    protocol                 = string<br>    cidr_blocks              = optional(list(string), null)<br>    ipv6_cidr_blocks         = optional(list(string), null)<br>    prefix_list_ids          = optional(list(string), null)<br>    self                     = optional(bool, false)<br>    description              = optional(string, "no description")<br>    source_security_group_id = optional(string, null)<br>  }))</pre> | `null` | no |
| <a name="input_security_group_rules_ooo"></a> [security\_group\_rules\_ooo](#input\_security\_group\_rules\_ooo) | A list of objects that contains the configuration for the security groups, and that normally<br>used in the context of ALB, testing traffic for ICMP packages, and other common use-cases<br>It can be used as an alternative of the values that are set in the variable 'security\_group\_rules'.<br>If set, it'll relate the sg\_name with the 'name' attribute passed into the<br>variable 'security\_group\_config'. The following attributes are supported:<br>- sg\_parent: The name of the security group.<br>- enable\_all\_inbound\_traffic: Whether to enable all inbound traffic or not.<br>- enable\_all\_inbound\_traffic\_from\_source: Whether to enable all inbound traffic from a specific source or not.<br>- enable\_inbound\_http: Whether to enable inbound HTTP traffic or not.<br>- enable\_inbound\_from\_custom\_port\_source: Whether to enable inbound traffic from a specific source or not.<br>- enable\_inbound\_from\_custom\_port\_cidr: Whether to enable inbound traffic from a specific CIDR or not.<br>- enable\_inbound\_http\_from\_source: Whether to enable inbound HTTP traffic from a specific source or not.<br>- enable\_inbound\_https: Whether to enable inbound HTTPS traffic or not.<br>- enable\_inbound\_https\_from\_source: Whether to enable inbound HTTPS traffic from a specific source or not.<br>- enable\_inbound\_ssh\_from\_anywhere: Whether to enable inbound SSH traffic from anywhere or not.<br>- enable\_inbound\_ssh\_from\_source: Whether to enable inbound SSH traffic from a specific source or not.<br>- enable\_inbound\_icmp\_from\_source: Whether to enable inbound ICMP traffic from a specific source or not.<br>- enable\_inbound\_icmp\_from\_anywhere: Whether to enable inbound ICMP traffic from anywhere or not.<br>- enable\_inbound\_mysql\_from\_source: Whether to enable inbound MySQL traffic from a specific source or not.<br>- enable\_outbound\_http: Whether to enable outbound HTTP traffic or not.<br>- enable\_outbound\_from\_custom\_port\_source: Whether to enable outbound traffic from a specific source or not.<br>- enable\_outbound\_from\_custom\_port\_cidr: Whether to enable outbound traffic from a specific CIDR or not.<br>- enable\_outbound\_http\_to\_source: Whether to enable outbound HTTP traffic to a specific source or not.<br>- enable\_outbound\_https: Whether to enable outbound HTTPS traffic or not.<br>- enable\_outbound\_https\_to\_source: Whether to enable outbound HTTPS traffic to a specific source or not.<br>- enable\_all\_outbound\_traffic: Whether to enable all outbound traffic or not.<br>- enable\_all\_outbound\_traffic\_to\_source: Whether to enable all outbound traffic to a specific source or not.<br>- source\_security\_group\_id: The ID of the source security group.<br>- custom\_port: The custom port to use for the inbound/outbound traffic. | <pre>list(object({<br>    sg_parent                               = string<br>    enable_all_inbound_traffic              = optional(bool, false)<br>    enable_all_inbound_traffic_from_source  = optional(bool, false)<br>    enable_inbound_http                     = optional(bool, false)<br>    enable_inbound_from_custom_port_source  = optional(bool, false)<br>    enable_inbound_from_custom_port_cidr    = optional(bool, false)<br>    enable_inbound_http_from_source         = optional(bool, false)<br>    enable_inbound_https                    = optional(bool, false)<br>    enable_inbound_https_from_source        = optional(bool, false)<br>    enable_inbound_ssh_from_anywhere        = optional(bool, false)<br>    enable_inbound_ssh_from_source          = optional(bool, false)<br>    enable_inbound_icmp_from_source         = optional(bool, false)<br>    enable_inbound_icmp_from_anywhere       = optional(bool, false)<br>    enable_inbound_mysql_from_source        = optional(bool, false)<br>    enable_outbound_http                    = optional(bool, false)<br>    enable_outbound_from_custom_port_source = optional(bool, false)<br>    enable_outbound_from_custom_port_cidr   = optional(bool, false)<br>    enable_outbound_http_to_source          = optional(bool, false)<br>    enable_outbound_https                   = optional(bool, false)<br>    enable_outbound_https_to_source         = optional(bool, false)<br>    enable_all_outbound_traffic             = optional(bool, false)<br>    enable_all_outbound_traffic_to_source   = optional(bool, false)<br>    source_security_group_id                = optional(string, null)<br>    custom_port                             = optional(number, null)<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
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
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
