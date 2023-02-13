<!-- BEGIN_TF_DOCS -->
# ☁️ Target Group
## Description

This module creates a target group, that can be easily attached into an existing application load balancer, or to any other (supported) type.
* 🚀 Creates a target group.
* 🚀 Creates a target group attachment.
* 🚀 Creates a target group health check.
* 🚀 Creates a target group stickiness.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/target-group"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  target_group_config = var.target_group_config
}
```
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
| [aws_lb_target_group.alb_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |

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
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_target_group_config"></a> [target\_group\_config](#input\_target\_group\_config) | A configuration object that allows the creation of multiple target groups, of type 'alb'. The support values are:<br>- name: The name of the target group. This name must be unique per region per account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.<br>- port: The port on which the targets are listening. Not used if the target is a Lambda function.<br>- protocol: The protocol to use for routing traffic to the targets. The default is the HTTP protocol.<br>- protocol\_version: The protocol version. The possible values are GRPC, HTTP1, HTTP2. The default is HTTP1.<br>- slow\_start: The time period, in seconds, during which the load balancer shifts traffic from the old target to the new target. During this time, the load balancer sends both new and old targets a proportional share of the traffic. After the time period ends, the load balancer shifts all traffic to the new target. The default is 30 seconds.<br>- deregistration\_delay: The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default is 15 seconds.<br>- load\_balancing\_algorithm\_type: The load balancing algorithm determines how the load balancer selects targets when routing requests. The value is round\_robin or least\_outstanding\_requests. The default is round\_robin.<br>- vpc\_id: The ID of the VPC for the targets.<br>- health\_check: An object that contains information about the health checks that Amazon performs on the targets in the target group. The object has the following attributes:<br>  - enabled: Indicates whether health checks are enabled. The default is true.<br>  - path: The destination for the health check request.<br>  - port: The port to use to connect with the target.<br>  - protocol: The protocol to use to connect with the target. The default is the HTTP protocol.<br>  - timeout: The amount of time, in seconds, during which no response means a failed health check. The default is 5 seconds. The range is 2-120 seconds.<br>  - interval: The approximate amount of time, in seconds, between health checks of an individual target. The default is 30 seconds. The range is 5-300 seconds.<br>  - healthy\_threshold: The number of consecutive health checks successes required before considering an unhealthy target healthy. The default is 5. The range is 2-10.<br>  - unhealthy\_threshold: The number of consecutive health check failures required before considering a target unhealthy. The default is 2. The range is 2-10.<br>  - matcher: The HTTP codes to use when checking for a successful response from a target. The default is 200.<br>- stickiness: An object that contains information about the stickiness settings. The object has the following attributes:<br>  - enabled: Indicates whether sticky sessions are enabled. The default is false.<br>  - type: The type of sticky sessions. The possible values are lb\_cookie or application\_cookie.<br>  - cookie\_duration: The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds). | <pre>list(object({<br>    name                          = string<br>    port                          = number<br>    protocol                      = optional(string, "HTTP")<br>    protocol_version              = optional(string, "HTTP1")<br>    slow_start                    = optional(number, 30)<br>    deregistration_delay          = optional(number, 15)<br>    load_balancing_algorithm_type = optional(string, "round_robin")<br>    vpc_id                        = string<br>    health_check = optional(object({<br>      enabled             = bool<br>      path                = string<br>      port                = number<br>      protocol            = string<br>      timeout             = number<br>      interval            = number<br>      healthy_threshold   = number<br>      unhealthy_threshold = number<br>      matcher             = string<br>    }), null)<br>    stickiness = optional(object({<br>      enabled         = bool<br>      type            = string<br>      cookie_duration = number<br>    }), null)<br>  }))</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
| <a name="output_target_group_alb_arn"></a> [target\_group\_alb\_arn](#output\_target\_group\_alb\_arn) | The ARN of the target group. |
| <a name="output_target_group_alb_arn_suffix"></a> [target\_group\_alb\_arn\_suffix](#output\_target\_group\_alb\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics. |
| <a name="output_target_group_alb_health_check"></a> [target\_group\_alb\_health\_check](#output\_target\_group\_alb\_health\_check) | A health check block. |
| <a name="output_target_group_alb_id"></a> [target\_group\_alb\_id](#output\_target\_group\_alb\_id) | The ID of the target group. |
| <a name="output_target_group_alb_name"></a> [target\_group\_alb\_name](#output\_target\_group\_alb\_name) | The name of the target group. |
| <a name="output_target_group_alb_port"></a> [target\_group\_alb\_port](#output\_target\_group\_alb\_port) | The port on which the targets are listening. |
| <a name="output_target_group_alb_protocol"></a> [target\_group\_alb\_protocol](#output\_target\_group\_alb\_protocol) | The protocol to use for routing traffic to the targets. |
| <a name="output_target_group_alb_stickiness"></a> [target\_group\_alb\_stickiness](#output\_target\_group\_alb\_stickiness) | A stickiness block. |
| <a name="output_target_group_alb_target_type"></a> [target\_group\_alb\_target\_type](#output\_target\_group\_alb\_target\_type) | The type of target that you must specify when registering targets with this target group. |
| <a name="output_target_group_alb_vpc_id"></a> [target\_group\_alb\_vpc\_id](#output\_target\_group\_alb\_vpc\_id) | The ID of the VPC for the targets. |
<!-- END_TF_DOCS -->
