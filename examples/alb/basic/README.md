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
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/alb | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_config"></a> [alb\_config](#input\_alb\_config) | A list of objects that contains the configuration for the ALB.<br>The following attributes are supported for each object:<br>- name: The name of the ALB.<br>- is\_internal: Whether the ALB is internal. If true, it will be deployed in private subnets.<br>- enable\_deletion\_protection: Whether to enable deletion protection on the ALB.<br>- subnets\_public: A list of public subnets IDs where the ALB will be deployed.<br>- security\_groups: A list of security group IDs to assign to the ALB.<br>- enable\_http2: Whether to enable HTTP/2.<br>- enable\_cross\_zone\_load\_balancing: Whether to enable cross-zone load balancing.<br>- access\_logs: An object that contains the configuration for access logs. The following attributes are supported:<br>  - bucket: The name of the S3 bucket for the access logs.<br>  - prefix: (Optional) The prefix for the location in the S3 bucket. If not specified, the ALB name will be used. | <pre>list(object({<br>    name                             = string<br>    is_internal                      = optional(bool, false)<br>    enable_deletion_protection       = optional(bool, false)<br>    subnets_public                   = optional(list(string), [])<br>    security_groups                  = optional(list(string), [])<br>    enable_http2                     = optional(bool, false)<br>    enable_cross_zone_load_balancing = optional(bool, false)<br>    access_logs = optional(object({<br>      bucket = string<br>      prefix = optional(string, "")<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | The ARN of the ALB. |
| <a name="output_alb_arn_suffix"></a> [alb\_arn\_suffix](#output\_alb\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics. |
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | The DNS name of the ALB. |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | The canonical hosted zone ID of the ALB (to be used in a Route 53 Alias record). |
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
<!-- END_TF_DOCS -->
