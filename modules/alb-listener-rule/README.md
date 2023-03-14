<!-- BEGIN_TF_DOCS -->
# ☁️ Application Load Balancer listener rule
## Description

This module creates an ALB listener rule that redirects traffic to a target group. For more information about this specific resource, please
refer to its official terraform-registry documentation: [aws_lb_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule).
A summary of its capabilities are:
* 🚀 Create an ALB listener rule
* 🚀 Create an ALB listener rule with multiple actions

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/alb-listener-rule"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  listener_rules_config = [{
    name         = "test"
    listener_arn = aws_alb_listener.alb_listener.arn
    priority     = 1
    type         = "fixed-response"
  }]

  action_redirect_config = var.action_redirect_config
  #  action_authenticate_cognito_config = var.action_authenticate_cognito_config
  action_forward_config        = var.action_forward_config
  action_fixed_response_config = var.action_fixed_response_config
  conditions_config            = var.conditions_config
  action_redirect_https        = var.action_redirect_https
}


resource "aws_alb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = []
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}

data "aws_vpc" "vpc" {
  default = false

  filter {
    name   = "tag:Name"
    values = ["tsn-sandbox-us-east-1-network-core-cross-vpc-backbone"]
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "alb-tg-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id
}
```
---
Simple example:
```hcl
aws_region = "us-east-1"
is_enabled = true

action_redirect_config = [
  {
    name = "test"
    type = "redirect"
    // actual rules to apply
    rules = [
      {
        redirect_config = {
          host        = "www.example.com"
          path        = "/new_path"
          port        = "443"
          protocol    = "HTTPS"
          query       = "query=parameter"
          status_code = "HTTP_301"
        }
      }
    ]
  }
]

conditions_config = [
  {
    name = "test"
    conditions = [
      {
        host_header_config = ["www.example.com"]
      }
    ]
  }
]
```

Example of multiple conditions
```hcl
aws_region = "us-east-1"
is_enabled = true

action_redirect_config = [
  {
    name = "test"
    type = "redirect"
    // actual rules to apply
    rules = [
      {
        redirect_config = {
          host        = "www.example.com"
          path        = "/new_path"
          port        = "443"
          protocol    = "HTTPS"
          query       = "query=parameter"
          status_code = "HTTP_301"
        }
      }
    ]
  }
]

conditions_config = [
  {
    name = "test"
    conditions = [
      {
        host_header_config = ["www.example.com"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        path_pattern_config = ["/*"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_request_method_config = ["GET"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_header_config = {
          header = "x-header"
          values = ["value"]
        }
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        query_string_config = {
          key   = "key"
          value = "value"
        }
      }
    ]
  }
]
```

Example of forward rule configuration:
```hcl
aws_region = "us-east-1"
is_enabled = true

action_forward_config = [
  {
    name = "test"
    rules = [
      {
        target_group = [
          {
            arn    = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"
            weight = 1
          },
          {
            arn    = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-other-targets/73e2d6bc24d8a067"
            weight = 1
          }
        ]
      }
    ]
  }
]

conditions_config = [
  {
    name = "test"
    conditions = [
      {
        host_header_config = ["www.example.com"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        path_pattern_config = ["/*"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_request_method_config = ["GET"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_header_config = {
          header = "x-header"
          values = ["value"]
        }
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        query_string_config = {
          key   = "key"
          value = "value"
        }
      }
    ]
  }
]
```

Example of fixed response configuration:
```hcl
aws_region = "us-east-1"
is_enabled = true

action_fixed_response_config = [
  {
    name = "test"
    rules = [
      {
        content_type = "text/plain"
        message_body = "test"
        status_code  = "200"
      }
    ]
  }
]

conditions_config = [
  {
    name = "test"
    conditions = [
      {
        host_header_config = ["www.example.com"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        path_pattern_config = ["/*"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_request_method_config = ["GET"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_header_config = {
          header = "x-header"
          values = ["value"]
        }
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        query_string_config = {
          key   = "key"
          value = "value"
        }
      }
    ]
  }
]
```

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener_rule.ooo_redirect_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.rule_fixed_response](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.rule_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.rule_redirection](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action_fixed_response_config"></a> [action\_fixed\_response\_config](#input\_action\_fixed\_response\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      content_type = optional(string, "text/plain")<br>      message_body = optional(string, "Fixed response content")<br>      status_code  = optional(string, "200")<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_forward_config"></a> [action\_forward\_config](#input\_action\_forward\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      target_group_arn = optional(string, null)<br>      stickiness = optional(object({<br>        duration = optional(number, null)<br>        enabled  = optional(bool, null)<br>      }), null)<br>      target_group = optional(list(object({<br>        arn    = optional(string, null)<br>        weight = optional(number, null)<br>      })), null)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_redirect_config"></a> [action\_redirect\_config](#input\_action\_redirect\_config) | n/a | <pre>list(object({<br>    name = string<br>    rules = list(object({<br>      host        = optional(string, null)<br>      path        = optional(string, null)<br>      port        = optional(string, null)<br>      protocol    = optional(string, null)<br>      query       = optional(string, null)<br>      status_code = optional(string, null)<br>    }))<br>  }))</pre> | `null` | no |
| <a name="input_action_redirect_https"></a> [action\_redirect\_https](#input\_action\_redirect\_https) | A list of objects that contains the configuration for the listener rules.<br>  Each object must contain the following attributes:<br>  - name: The name of the listener rule.<br>  - listener\_arn: The ARN of the listener to which the rule is associated.<br>  - priority: The priority for the rule. This must be unique for each rule in the same listener.<br>  - host\_header\_condition: The host header to match.<br>  - path\_pattern\_condition: The path pattern to match.<br>  - http\_request\_method\_condition: The http request method to match.<br>  - http\_header\_condition: The http header to match. | <pre>list(object({<br>    name                          = string<br>    listener_arn                  = string<br>    host_header_condition         = optional(list(string), null)<br>    priority                      = optional(number, null)<br>    path_pattern_condition        = optional(list(string), null)<br>    http_request_method_condition = optional(list(string), null)<br>    http_header_condition = optional(object({<br>      header = string<br>      values = list(string)<br>    }), null)<br>  }))</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_conditions_config"></a> [conditions\_config](#input\_conditions\_config) | variable "action\_authenticate\_cognito\_config" { type = list(object({ name = string rules = list(object({ user\_pool\_arn                       = optional(string, null) user\_pool\_client\_id                 = optional(string, null) user\_pool\_domain                    = optional(string, null) session\_cookie\_name                 = optional(string, null) session\_timeout                     = optional(number, null) scope                               = optional(string, null) on\_unauthenticated\_request          = optional(string, null) authentication\_request\_extra\_params = optional(map(string), null) on\_authenticated\_request            = optional(string, null) })) })) default = null } | <pre>list(object({<br>    name = string<br>    conditions = list(object({<br>      host_header_config  = optional(list(string), null)<br>      path_pattern_config = optional(list(string), null)<br>      http_header_config = optional(object({<br>        header = optional(string, null)<br>        values = optional(list(string), null)<br>      }), null)<br>      query_string_config = optional(object({<br>        key   = optional(string, null)<br>        value = optional(string, null)<br>      }), null)<br>      http_request_method_config = optional(list(string), null)<br>    }))<br>  }))</pre> | `null` | no |
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
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->
