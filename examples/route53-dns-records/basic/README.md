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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/route53-dns-records | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_record_type_alias_config"></a> [record\_type\_alias\_config](#input\_record\_type\_alias\_config) | A list of objects that contains the following attributes:<br>  - name: The name of the record.<br>  - zone\_name: The name of the zone to contain this record.<br>  - zone\_id: The ID of the zone to contain this record.<br>  - allow\_overwrite: If true, any existing records with the same name and type will be overwritten.<br>If false, all existing records with the same name and type will be overwritten.<br>  - ttl: The TTL of the record.<br>  - enable\_www\_cname: If true, a CNAME record will be created for www.<name>.<br>  - alias\_target\_config: A object that contains the following attributes:<br>    - target\_zone\_id: The ID of the zone to contain the resource record set that you're<br>creating the alias for.<br>    - target\_dns\_name: The value that you specify depends on where you want to route<br>    - target\_enable\_health\_check: If true, the alias resource record set inherits the health | <pre>list(object({<br>    name             = string<br>    zone_name        = optional(string, null)<br>    zone_id          = optional(string, null)<br>    allow_overwrite  = optional(bool, false)<br>    ttl              = optional(number, 30)<br>    enable_www_cname = optional(bool, false)<br>    alias_target_config = object({<br>      target_zone_id             = string<br>      target_dns_name            = string<br>      target_enable_health_check = optional(bool, false)<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_dns_alias_fqdn"></a> [dns\_alias\_fqdn](#output\_dns\_alias\_fqdn) | The FQDN of the DNS alias record. |
| <a name="output_dns_alias_id"></a> [dns\_alias\_id](#output\_dns\_alias\_id) | The ID of the DNS alias record. |
| <a name="output_dns_alias_name"></a> [dns\_alias\_name](#output\_dns\_alias\_name) | The name of the DNS alias record. |
| <a name="output_dns_alias_set_identifier"></a> [dns\_alias\_set\_identifier](#output\_dns\_alias\_set\_identifier) | The set identifier of the DNS alias record. |
| <a name="output_dns_alias_zone_id"></a> [dns\_alias\_zone\_id](#output\_dns\_alias\_zone\_id) | The zone ID of the DNS alias record. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
