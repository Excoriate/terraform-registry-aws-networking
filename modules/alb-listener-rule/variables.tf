variable "is_enabled" {
  type        = bool
  description = <<EOF
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
EOF
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

/*
-------------------------------------
Custom input variables
-------------------------------------
*/
variable "listener_rules_config" {
  type = list(object({
    name         = string
    listener_arn = string
    priority     = optional(number, null)
  }))
  description = <<EOF
  A list of objects that contains the configuration for the listener rules.
  Each object must contain the following attributes:
  - name: The name of the listener rule.
  - listener_arn: The ARN of the listener to which the rule is associated.
  - priority: The priority for the rule. This must be unique for each rule in the same listener.
  EOF
  default     = null
}

variable "action_redirect_config" {
  type = list(object({
    name = string
    rules = list(object({
      host        = optional(string, null)
      path        = optional(string, null)
      port        = optional(string, null)
      protocol    = optional(string, null)
      query       = optional(string, null)
      status_code = optional(string, null)
    }))
  }))
  default = null
}

variable "action_fixed_response_config" {
  type = list(object({
    name = string
    rules = list(object({
      content_type = optional(string, "text/plain")
      message_body = optional(string, "Fixed response content")
      status_code  = optional(string, "200")
    }))
  }))
  default = null
}

variable "action_forward_config" {
  type = list(object({
    name = string
    rules = list(object({
      target_group_arn = optional(string, null)
      stickiness = optional(object({
        duration = optional(number, null)
        enabled  = optional(bool, null)
      }), null)
      target_group = optional(list(object({
        target_group_arn = optional(string, null)
        weight           = optional(number, null)
      })), null)
    }))
  }))
  default = null
}

variable "action_authenticate_cognito_config" {
  type = list(object({
    name = string
    rules = list(object({
      user_pool_arn                       = optional(string, null)
      user_pool_client_id                 = optional(string, null)
      user_pool_domain                    = optional(string, null)
      session_cookie_name                 = optional(string, null)
      session_timeout                     = optional(number, null)
      scope                               = optional(string, null)
      on_unauthenticated_request          = optional(string, null)
      authentication_request_extra_params = optional(map(string), null)
      on_authenticated_request            = optional(string, null)
    }))
  }))
  default = null
}

variable "conditions_config" {
  type = list(object({
    name = string
    conditions = list(object({
      host_header_config  = optional(list(string), null)
      path_pattern_config = optional(list(string), null)
      http_header_config = optional(object({
        header = optional(string, null)
        values = optional(list(string), null)
      }), null)
      query_string_config = optional(object({
        key   = optional(string, null)
        value = optional(string, null)
      }), null)
      http_request_method_config = optional(list(string), null)
    }))
  }))
  default = null
}
