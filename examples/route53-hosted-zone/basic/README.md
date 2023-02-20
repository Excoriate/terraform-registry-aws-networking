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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/route53-hosted-zone | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_hosted_zone_config"></a> [hosted\_zone\_config](#input\_hosted\_zone\_config) | A list of objects that contains the configuration for the hosted zones to be created.<br>  Each object must contain the following attributes:<br>  - name: The name of the hosted zone.<br>  - comment: (Optional) A comment for the hosted zone.<br>  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the hosted zone.<br>    - vpc\_id: The ID of the VPC to associate with the hosted zone.<br>    - vpc\_region: The region of the VPC to associate with the hosted zone.<br>  - zone\_delegation\_config: (Optional) A map of attributes that contains the configuration for the opinionated hosted-zone delegation.<br>    - name\_servers: A list of name servers to delegate the zone to.<br>    - child\_zone\_name: The name of the child zone to create. | <pre>list(object({<br>    name    = string<br>    comment = optional(string, null)<br>    vpc = optional(object({<br>      vpc_id     = string<br>      vpc_region = string<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_hosted_zone_subdomains"></a> [hosted\_zone\_subdomains](#input\_hosted\_zone\_subdomains) | A list of objects that contains the configuration for the subdomains to be created.<br>  Each object must contain the following attributes:<br>  - name: The name of the hosted zone.<br>  - subdomain: The name of the subdomain to create.<br>  - name\_servers: A list of name servers to delegate the subdomain to.<br>  - ttl: (Optional) The TTL of the subdomain delegation. | <pre>list(object({<br>    name         = string<br>    subdomain    = string<br>    name_servers = list(string)<br>    ttl          = optional(number, 60)<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_hosted_zone_id"></a> [hosted\_zone\_id](#output\_hosted\_zone\_id) | The ID of the hosted zone. |
| <a name="output_hosted_zone_name"></a> [hosted\_zone\_name](#output\_hosted\_zone\_name) | The name of the hosted zone. |
| <a name="output_hosted_zone_name_servers"></a> [hosted\_zone\_name\_servers](#output\_hosted\_zone\_name\_servers) | A list of name servers in associated (or default) delegation set. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
