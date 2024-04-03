<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/alb-listener-rule | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_alb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.alb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.alb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_authenticate_cognito_config"></a> [action\_authenticate\_cognito\_config](#input\_action\_authenticate\_cognito\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      user_pool_arn                       = optional(string, null)<br>      user_pool_client_id                 = optional(string, null)<br>      user_pool_domain                    = optional(string, null)<br>      session_cookie_name                 = optional(string, null)<br>      session_timeout                     = optional(number, null)<br>      scope                               = optional(string, null)<br>      on_unauthenticated_request          = optional(string, null)<br>      authentication_request_extra_params = optional(map(string), null)<br>      on_authenticated_request            = optional(string, null)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_fixed_response_config"></a> [action\_fixed\_response\_config](#input\_action\_fixed\_response\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      content_type = optional(string, "text/plain")<br>      message_body = optional(string, "Fixed response content")<br>      status_code  = optional(string, "200")<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_forward_config"></a> [action\_forward\_config](#input\_action\_forward\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      target_group_arn = optional(string, null)<br>      stickiness = optional(object({<br>        duration = optional(number, null)<br>        enabled  = optional(bool, null)<br>      }), null)<br>      target_group = optional(list(object({<br>        arn    = optional(string, null)<br>        weight = optional(number, null)<br>      })), null)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_redirect_config"></a> [action\_redirect\_config](#input\_action\_redirect\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      host        = optional(string, null)<br>      path        = optional(string, null)<br>      port        = optional(string, null)<br>      protocol    = optional(string, null)<br>      query       = optional(string, null)<br>      status_code = optional(string, null)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_redirect_https"></a> [action\_redirect\_https](#input\_action\_redirect\_https) | A list of objects that contains the configuration for the listener rules.<br>  Each object must contain the following attributes:<br>  - name: The name of the listener rule.<br>  - listener\_arn: The ARN of the listener to which the rule is associated.<br>  - priority: The priority for the rule. This must be unique for each rule in the same listener.<br>  - host\_header\_condition: The host header to match.<br>  - path\_pattern\_condition: The path pattern to match.<br>  - http\_request\_method\_condition: The http request method to match.<br>  - http\_header\_condition: The http header to match. | <pre>list(object({<br>    name                          = string<br>    listener_arn                  = string<br>    host_header_condition         = optional(list(string), null)<br>    priority                      = optional(number, null)<br>    path_pattern_condition        = optional(list(string), null)<br>    http_request_method_condition = optional(list(string), null)<br>    http_header_condition = optional(object({<br>      header = string<br>      values = list(string)<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_conditions_config"></a> [conditions\_config](#input\_conditions\_config) | n/a | <pre>list(object({<br>    name = string<br>    conditions = list(object({<br>      host_header_config  = optional(list(string), null)<br>      path_pattern_config = optional(list(string), null)<br>      http_header_config = optional(object({<br>        header = optional(string, null)<br>        values = optional(list(string), null)<br>      }), null)<br>      query_string_config = optional(object({<br>        key   = optional(string, null)<br>        value = optional(string, null)<br>      }), null)<br>      http_request_method_config = optional(list(string), null)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_listener_rules_config"></a> [listener\_rules\_config](#input\_listener\_rules\_config) | A list of objects that contains the configuration for the listener rules.<br>  Each object must contain the following attributes:<br>  - name: The name of the listener rule.<br>  - listener\_arn: The ARN of the listener to which the rule is associated.<br>  - priority: The priority for the rule. This must be unique for each rule in the same listener.<br>  - type: The type of action. Valid values are forward, authenticate-cognito, authenticate-oidc, redirect, fixed-response. | <pre>list(object({<br>    name         = string<br>    listener_arn = string<br>    priority     = optional(number, null)<br>    type         = optional(string, "forward")<br>  }))</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_listener_parent_configuration"></a> [listener\_parent\_configuration](#output\_listener\_parent\_configuration) | The listener parent configuration. |
| <a name="output_listener_rule_fixed_response"></a> [listener\_rule\_fixed\_response](#output\_listener\_rule\_fixed\_response) | The listener rule for fixed response. |
| <a name="output_listener_rule_host_header"></a> [listener\_rule\_host\_header](#output\_listener\_rule\_host\_header) | The listener rule for the forward action |
| <a name="output_listener_rule_redirect"></a> [listener\_rule\_redirect](#output\_listener\_rule\_redirect) | The listener rule for redirect. |
<!-- END_TF_DOCS -->
