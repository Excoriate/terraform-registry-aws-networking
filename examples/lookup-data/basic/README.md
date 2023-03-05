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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/lookup-data | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_data"></a> [vpc\_data](#input\_vpc\_data) | n/a | <pre>object({<br>    name                      = string<br>    subnet_public_identifier  = optional(string, "public")<br>    subnet_private_identifier = optional(string, "private")<br>    retrieve_subnets          = optional(bool, false)<br>    retrieve_subnets_private  = optional(bool, false)<br>    retrieve_subnets_public   = optional(bool, false)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_subnet_all"></a> [subnet\_all](#output\_subnet\_all) | The all subnet data. |
| <a name="output_subnet_all_ids"></a> [subnet\_all\_ids](#output\_subnet\_all\_ids) | All subnet ids |
| <a name="output_subnet_private_data"></a> [subnet\_private\_data](#output\_subnet\_private\_data) | The private subnet data. |
| <a name="output_subnet_public_data"></a> [subnet\_public\_data](#output\_subnet\_public\_data) | The public subnet data. |
| <a name="output_vpc_data"></a> [vpc\_data](#output\_vpc\_data) | The VPC data. |
<!-- END_TF_DOCS -->
