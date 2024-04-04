<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/security-group-v2 | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. Useful for stack-composite<br>modules that conditionally include resources provided by this module. | `bool` | `true` | no |
| <a name="input_security_group_config"></a> [security\_group\_config](#input\_security\_group\_config) | An object  representing the configuration for a security group, facilitating detailed control over ingress and egress rules.<br><br>- `name`: The name of the security group.<br>- `description`: Describes the security group (default: "Managed by Terraform").<br>- `vpc_id`: The VPC ID for the security group (See [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)).<br><br>Each `ingress` and `egress` rule object can have the following attributes:<br><br>- `description`: Rule description (default: "Ingress Rule" or "Egress Rule").<br>- `from_port`: Starting port range or ICMP type number.<br>- `to_port`: Ending port range or ICMP code number.<br>- `protocol`: Protocol type (e.g., "tcp", "udp", "icmp", or "-1" for all).<br>- `cidr_blocks`: CIDR blocks allowed (default: empty).<br>- `ipv6_cidr_blocks`: IPv6 CIDR blocks allowed (default: empty).<br>- `prefix_list_ids`: Prefix list IDs for VPC endpoint access (default: empty).<br>- `security_groups`: Security group IDs allowed (default: empty).<br>- `self`: Apply the rule to the security group itself (default: false).<br><br>For more details on defining security groups with Terraform, refer to the [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group). | <pre>object({<br>    name        = string<br>    description = optional(string, "Managed by Terraform")<br>    vpc_id      = string<br>    ingress     = optional(list(object({<br>      description      = optional(string, "Ingress Rule")<br>      from_port        = number<br>      to_port          = number<br>      protocol         = string<br>      cidr_blocks      = optional(list(string), [])<br>      ipv6_cidr_blocks = optional(list(string), [])<br>      prefix_list_ids  = optional(list(string), [])<br>      security_groups  = optional(list(string), [])<br>      self             = optional(bool, false)<br>    })), [])<br>    egress = optional(list(object({<br>      description      = optional(string, "Egress Rule")<br>      from_port        = number<br>      to_port          = number<br>      protocol         = string<br>      cidr_blocks      = optional(list(string), [])<br>      ipv6_cidr_blocks = optional(list(string), [])<br>      prefix_list_ids  = optional(list(string), [])<br>      security_groups  = optional(list(string), [])<br>      self             = optional(bool, false)<br>    })), [])<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | The ARN of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created. |
| <a name="output_security_group_description"></a> [security\_group\_description](#output\_security\_group\_description) | The description of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created. |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group created by the module. Returns an empty string if the module is not enabled or no security group is created. |
| <a name="output_security_group_vpc_id"></a> [security\_group\_vpc\_id](#output\_security\_group\_vpc\_id) | The VPC ID associated with the security group created by the module. Returns an empty string if the module is not enabled or no security group is created. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
