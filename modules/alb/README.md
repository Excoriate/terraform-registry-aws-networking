<!-- BEGIN_TF_DOCS -->
# ☁️ AWS Application Load Balancer module
## Description

This module creates an Application load balancer, following what's described in the following [documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html).
This Application load balancer comes without an ALB target-group. In order to attach one, it's recommended that you use the `alb-target-group` module, which is available in this repository.
* 🚀 Creates an application load balancer.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/alb"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  alb_config = var.alb_config
}
```

An example of multiple security groups, created at once:
```hcl
aws_region = "us-east-1"
is_enabled = true

alb_config = [
  {
    name = "my-simple-alb"
  }
]

```
An example of multiple ALB created at once:
```hcl
aws_region = "us-east-1"
is_enabled = true

alb_config = [
  {
    name = "my-simple-alb"
  },
  {
    name = "another-alb"
  }
]

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
output "alb_arn" {
  value       = [for alb in aws_lb.this : alb.arn]
  description = "The ARN of the ALB."
}

output "alb_arn_suffix" {
  value       = [for alb in aws_lb.this : alb.arn_suffix]
  description = "The ARN suffix for use with CloudWatch Metrics."
}

output "alb_dns_name" {
  value       = [for alb in aws_lb.this : alb.dns_name]
  description = "The DNS name of the ALB."
}

output "alb_zone_id" {
  value       = [for alb in aws_lb.this : alb.zone_id]
  description = "The canonical hosted zone ID of the ALB (to be used in a Route 53 Alias record)."
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
| [aws_lb.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

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
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
