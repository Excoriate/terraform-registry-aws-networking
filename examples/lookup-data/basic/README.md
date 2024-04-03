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
| <a name="input_dns_data"></a> [dns\_data](#input\_dns\_data) | A set of options to perform lookup and search over AWS configured DNS components. The allowed<br>filters and/or search criteria are:<br>  - domain: The domain name to search for.<br>  - fetch\_zone: Whether to fetch the zone data.<br>  - fetch\_acm\_certificate: Whether to fetch the ACM certificate data. | <pre>object({<br>    domain                = string<br>    fetch_zone            = optional(bool, false)<br>    fetch_acm_certificate = optional(bool, false)<br>  })</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_data"></a> [vpc\_data](#input\_vpc\_data) | A set of options to perform lookup and search over AWS configured network components. The allowed<br>filters and/or search criteria are:<br>  - name                     : The name of the VPC to search for.<br>  - subnet\_public\_identifier : The identifier of the public subnet to search for.<br>  - subnet\_private\_identifier: The identifier of the private subnet to search for.<br>  - retrieve\_subnets         : Whether to retrieve the subnets of the VPC.<br>  - retrieve\_subnets\_private : Whether to retrieve the private subnets of the VPC.<br>  - retrieve\_subnets\_public  : Whether to retrieve the public subnets of the VPC.<br>  - filter\_by\_az             : Whether to filter the subnets by availability zone. | <pre>object({<br>    name                      = string<br>    subnet_public_identifier  = optional(string, "public")<br>    subnet_private_identifier = optional(string, "private")<br>    retrieve_subnets          = optional(bool, false)<br>    retrieve_subnets_private  = optional(bool, false)<br>    retrieve_subnets_public   = optional(bool, false)<br>    filter_by_az              = optional(bool, false)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_dns_data_acm_certificate"></a> [dns\_data\_acm\_certificate](#output\_dns\_data\_acm\_certificate) | The ACM certificate data. |
| <a name="output_dns_data_hosted_zone"></a> [dns\_data\_hosted\_zone](#output\_dns\_data\_hosted\_zone) | The hosted zone data. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_subnet_all"></a> [subnet\_all](#output\_subnet\_all) | The all subnet data. |
| <a name="output_subnet_all_ids"></a> [subnet\_all\_ids](#output\_subnet\_all\_ids) | All subnet ids |
| <a name="output_subnet_private_az_a_data"></a> [subnet\_private\_az\_a\_data](#output\_subnet\_private\_az\_a\_data) | The private subnet data for AZ A. |
| <a name="output_subnet_private_az_a_ids_data"></a> [subnet\_private\_az\_a\_ids\_data](#output\_subnet\_private\_az\_a\_ids\_data) | The private subnet ids data for AZ A. |
| <a name="output_subnet_private_az_b_data"></a> [subnet\_private\_az\_b\_data](#output\_subnet\_private\_az\_b\_data) | The private subnet data for AZ B. |
| <a name="output_subnet_private_az_b_ids_data"></a> [subnet\_private\_az\_b\_ids\_data](#output\_subnet\_private\_az\_b\_ids\_data) | The private subnet ids data for AZ B. |
| <a name="output_subnet_private_az_c_data"></a> [subnet\_private\_az\_c\_data](#output\_subnet\_private\_az\_c\_data) | The private subnet data for AZ C. |
| <a name="output_subnet_private_az_c_ids_data"></a> [subnet\_private\_az\_c\_ids\_data](#output\_subnet\_private\_az\_c\_ids\_data) | The private subnet ids data for AZ C. |
| <a name="output_subnet_private_data"></a> [subnet\_private\_data](#output\_subnet\_private\_data) | The private subnet data. |
| <a name="output_subnet_public_az_a_data"></a> [subnet\_public\_az\_a\_data](#output\_subnet\_public\_az\_a\_data) | The public subnet data for AZ A. |
| <a name="output_subnet_public_az_a_ids_data"></a> [subnet\_public\_az\_a\_ids\_data](#output\_subnet\_public\_az\_a\_ids\_data) | The public subnet ids data for AZ A. |
| <a name="output_subnet_public_az_b_data"></a> [subnet\_public\_az\_b\_data](#output\_subnet\_public\_az\_b\_data) | The public subnet data for AZ B. |
| <a name="output_subnet_public_az_b_ids_data"></a> [subnet\_public\_az\_b\_ids\_data](#output\_subnet\_public\_az\_b\_ids\_data) | The public subnet ids data for AZ B. |
| <a name="output_subnet_public_az_c_data"></a> [subnet\_public\_az\_c\_data](#output\_subnet\_public\_az\_c\_data) | The public subnet data for AZ C. |
| <a name="output_subnet_public_az_c_ids_data"></a> [subnet\_public\_az\_c\_ids\_data](#output\_subnet\_public\_az\_c\_ids\_data) | The public subnet ids data for AZ C. |
| <a name="output_subnet_public_data"></a> [subnet\_public\_data](#output\_subnet\_public\_data) | The public subnet data. |
| <a name="output_vpc_data"></a> [vpc\_data](#output\_vpc\_data) | The VPC data. |
<!-- END_TF_DOCS -->
