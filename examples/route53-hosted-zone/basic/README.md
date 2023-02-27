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
| <a name="input_hosted_zone_stand_alone"></a> [hosted\_zone\_stand\_alone](#input\_hosted\_zone\_stand\_alone) | A list of objects that contains the configuration for the hosted zones to be created.<br>  Each object must contain the following attributes:<br>  - name: The name of the hosted zone.<br>  - comment: (Optional) A comment for the hosted zone.<br>  - force\_destroy: (Optional) Whether to destroy the hosted zone even if it contains records.<br>  - delegation\_set\_id: (Optional) The ID of the reusable delegation set to associate with the hosted zone.<br>  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the hosted zone.<br>    - vpc\_id: The ID of the VPC to associate with the hosted zone.<br>    - vpc\_region: The region of the VPC to associate with the hosted zone.<br>  - zone\_delegation\_config: (Optional) A map of attributes that contains the configuration for the opinionated hosted-zone delegation.<br>    - name\_servers: A list of name servers to delegate the zone to.<br>    - child\_zone\_name: The name of the child zone to create. | <pre>list(object({<br>    name              = string<br>    comment           = optional(string, null)<br>    force_destroy     = optional(bool, false)<br>    delegation_set_id = optional(string, null)<br>    vpc = optional(object({<br>      vpc_id     = string<br>      vpc_region = string<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_hosted_zone_stand_alone_name_servers"></a> [hosted\_zone\_stand\_alone\_name\_servers](#input\_hosted\_zone\_stand\_alone\_name\_servers) | A list of name servers (NS) records that will be created, as part o the stand-alone hosted zones.<br>Each object must contain the following attributes:<br>- record\_name: The name of the NS record.<br>- hosted\_zone\_name: The name of the hosted zone to create the NS records.<br>- name\_servers: A list of name servers to delegate the zone to.<br>- ttl: (Optional) The TTL for the NS records. | <pre>list(object({<br>    hosted_zone_name = string,<br>    name_servers     = list(string)<br>    record_name      = string<br>    ttl              = optional(number, 90)<br>  }))</pre> | `null` | no |
| <a name="input_hosted_zone_subdomains_childs"></a> [hosted\_zone\_subdomains\_childs](#input\_hosted\_zone\_subdomains\_childs) | A list of objects that contains the configuration for the subdomains to be created.<br>  Each object must contain the following attributes:<br>  - domain: The domain of the subdomain.<br>  - name: The name of the subdomain.<br>  - comment: (Optional) A comment for the subdomain.<br>  - force\_destroy: (Optional) Whether to destroy the subdomain even if it contains records.<br>  - ttl: (Optional) The TTL for the subdomain.<br>  - delegation\_set\_id: (Optional) The ID of the reusable delegation set to associate with the subdomain.<br>  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the subdomain.<br>    - vpc\_id: The ID of the VPC to associate with the subdomain.<br>    - vpc\_region: The region of the VPC to associate with the subdomain. | <pre>list(object({<br>    domain            = string<br>    name              = string<br>    comment           = optional(string, null)<br>    force_destroy     = optional(bool, false)<br>    ttl               = optional(number, 90)<br>    delegation_set_id = optional(string, null)<br>    vpc = optional(object({<br>      vpc_id     = string<br>      vpc_region = string<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_hosted_zone_subdomains_parent"></a> [hosted\_zone\_subdomains\_parent](#input\_hosted\_zone\_subdomains\_parent) | An object that contains the configuration for the parent hosted zone to be created.<br>  The object must contain the following attributes:<br>  - name: The name of the hosted zone.<br>  - force\_destroy: (Optional) Whether to destroy the hosted zone even if it contains records.<br>  - delegation\_set\_id: (Optional) The ID of the reusable delegation set to associate with the hosted zone.<br>  - comment: (Optional) A comment for the hosted zone.<br>  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the hosted zone.<br>    - vpc\_id: The ID of the VPC to associate with the hosted zone.<br>    - vpc\_region: The region of the VPC to associate with the hosted zone. | <pre>object({<br>    name              = string<br>    comment           = optional(string, null)<br>    force_destroy     = optional(bool, false)<br>    delegation_set_id = optional(string, null)<br>    vpc = optional(object({<br>      vpc_id     = string<br>      vpc_region = string<br>    }), null)<br>  })</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_feature_flag_hosted_zone_stand_alone_enabled"></a> [feature\_flag\_hosted\_zone\_stand\_alone\_enabled](#output\_feature\_flag\_hosted\_zone\_stand\_alone\_enabled) | Whether the feature flag for the stand alone hosted zone is enabled or not. |
| <a name="output_feature_flag_hosted_zone_subdomains_childs_enabled"></a> [feature\_flag\_hosted\_zone\_subdomains\_childs\_enabled](#output\_feature\_flag\_hosted\_zone\_subdomains\_childs\_enabled) | Whether the feature flag for the stand alone hosted zone is enabled or not. |
| <a name="output_feature_flag_hosted_zone_subdomains_parent_enabled"></a> [feature\_flag\_hosted\_zone\_subdomains\_parent\_enabled](#output\_feature\_flag\_hosted\_zone\_subdomains\_parent\_enabled) | Whether the feature flag for the stand alone hosted zone is enabled or not. |
| <a name="output_hosted_zone_stand_alone_id"></a> [hosted\_zone\_stand\_alone\_id](#output\_hosted\_zone\_stand\_alone\_id) | The ID of the stand alone hosted zone. |
| <a name="output_hosted_zone_stand_alone_name"></a> [hosted\_zone\_stand\_alone\_name](#output\_hosted\_zone\_stand\_alone\_name) | The Name of the stand alone hosted zone. |
| <a name="output_hosted_zone_stand_alone_name_servers"></a> [hosted\_zone\_stand\_alone\_name\_servers](#output\_hosted\_zone\_stand\_alone\_name\_servers) | The name servers of the stand alone hosted zone. |
| <a name="output_hosted_zone_subdomains_childs_id"></a> [hosted\_zone\_subdomains\_childs\_id](#output\_hosted\_zone\_subdomains\_childs\_id) | The ID of the child hosted zone for the subdomains. |
| <a name="output_hosted_zone_subdomains_childs_name"></a> [hosted\_zone\_subdomains\_childs\_name](#output\_hosted\_zone\_subdomains\_childs\_name) | The Name of the child hosted zone for the subdomains. |
| <a name="output_hosted_zone_subdomains_childs_name_servers"></a> [hosted\_zone\_subdomains\_childs\_name\_servers](#output\_hosted\_zone\_subdomains\_childs\_name\_servers) | The name servers of the child hosted zone for the subdomains. |
| <a name="output_hosted_zone_subdomains_parent_id"></a> [hosted\_zone\_subdomains\_parent\_id](#output\_hosted\_zone\_subdomains\_parent\_id) | The ID of the parent hosted zone for the subdomains. |
| <a name="output_hosted_zone_subdomains_parent_name"></a> [hosted\_zone\_subdomains\_parent\_name](#output\_hosted\_zone\_subdomains\_parent\_name) | The Name of the parent hosted zone for the subdomains. |
| <a name="output_hosted_zone_subdomains_parent_name_servers"></a> [hosted\_zone\_subdomains\_parent\_name\_servers](#output\_hosted\_zone\_subdomains\_parent\_name\_servers) | The name servers of the parent hosted zone for the subdomains. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
