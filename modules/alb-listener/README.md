<!-- BEGIN_TF_DOCS -->
# ☁️ Application load balancer listeners.
## Description

This module creates an application load balancer listener, one or many. It supports the following capabilities
* 🚀 Create one or many listeners
* 🚀 It creates one or many forward/redirect rules
For more information on the AWS Application Load Balancer, see the [AWS documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html).
[ ] TODO: Add support for looking up the ALB, when its ARN isn't passed and instead a name (friendly) can be passed.
[ ] TODO: Add support for looking up the ALB target group, when its ARN isn't passed and instead a name (friendly) can be passed.
[ ] TODO: Add support rules (pending to define whether it'd be better a separated module)

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/alb-listener"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  alb_listeners_config   = var.alb_listeners_config
  alb_listener_ooo_http  = var.alb_listener_ooo_http
  alb_listener_ooo_https = var.alb_listener_ooo_https
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
| [aws_alb_listener.http_ooo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener.https_ooo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_lb_listener.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_listener_ooo_http"></a> [alb\_listener\_ooo\_http](#input\_alb\_listener\_ooo\_http) | A list of objects that contains the configuration for the ALB listeners.<br>Current supported attributes are:<br>- name: The name of the listener. Friendly name, to internally manage multiple TF resources.<br>- target\_group\_arn: The ARN of the target group.<br>- alb\_arn: The ARN of the ALB. | <pre>list(object({<br>    name             = string<br>    alb_arn          = string<br>    target_group_arn = string<br>  }))</pre> | `null` | no |
| <a name="input_alb_listener_ooo_https"></a> [alb\_listener\_ooo\_https](#input\_alb\_listener\_ooo\_https) | A list of objects that contains the configuration for the ALB listeners.<br>Current supported attributes are:<br>- name: The name of the listener. Friendly name, to internally manage multiple TF resources.<br>- alb\_arn: The ARN of the ALB.<br>- certificate\_arn: The ARN of the certificate.<br>- target\_group\_arn: The ARN of the target group. | <pre>list(object({<br>    name             = string<br>    certificate_arn  = string<br>    target_group_arn = string<br>    alb_arn          = string<br>  }))</pre> | `null` | no |
| <a name="input_alb_listeners_config"></a> [alb\_listeners\_config](#input\_alb\_listeners\_config) | A list of objects that contains the configuration for the ALB listeners.<br>Current supported attributes are:<br>- alb\_arn: The ARN of the ALB.<br>- port: The port on which the listener is listening.<br>- protocol: The protocol for connections from clients to the load balancer.<br>- ssl\_policy: The security policy that defines which ciphers and protocols are<br>  supported. The default is the current predefined security policy.<br>- certificate\_arn: The ARN of the certificate.<br>- default\_action: The default action for the listener. | <pre>list(object({<br>    alb_arn         = string<br>    port            = number<br>    protocol        = string<br>    ssl_policy      = optional(string, null)<br>    certificate_arn = optional(string, null)<br>    default_action = object({<br>      type             = optional(string, "forward")<br>      target_group_arn = optional(string, null)<br>      forward = optional(object({<br>        target_group = list(object({<br>          target_group_arn = string<br>          weight           = optional(number, null)<br>        }))<br>        stickiness = optional(object({<br>          duration = optional(number, null)<br>          enabled  = optional(bool, null)<br>        }), null)<br>      }), null)<br>    })<br>  }))</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_listener_arn"></a> [alb\_listener\_arn](#output\_alb\_listener\_arn) | The ARN of the ALB listener. |
| <a name="output_alb_listener_id"></a> [alb\_listener\_id](#output\_alb\_listener\_id) | The ID of the ALB listener. |
| <a name="output_alb_listener_ooo_http_arn"></a> [alb\_listener\_ooo\_http\_arn](#output\_alb\_listener\_ooo\_http\_arn) | The out-of-band healthcheck of the ALB listener. |
| <a name="output_alb_listener_ooo_http_id"></a> [alb\_listener\_ooo\_http\_id](#output\_alb\_listener\_ooo\_http\_id) | The out-of-band healthcheck of the ALB listener. |
| <a name="output_alb_listener_ooo_https_arn"></a> [alb\_listener\_ooo\_https\_arn](#output\_alb\_listener\_ooo\_https\_arn) | The out-of-band healthcheck of the ALB listener. |
| <a name="output_alb_listener_ooo_https_id"></a> [alb\_listener\_ooo\_https\_id](#output\_alb\_listener\_ooo\_https\_id) | The out-of-band healthcheck of the ALB listener. |
| <a name="output_alb_listener_ssl_policy"></a> [alb\_listener\_ssl\_policy](#output\_alb\_listener\_ssl\_policy) | The SSL policy of the ALB listener. |
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
