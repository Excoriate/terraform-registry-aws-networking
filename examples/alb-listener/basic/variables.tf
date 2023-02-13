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
variable "alb_listeners_config" {
  type = list(object({
    alb_arn         = string
    port            = number
    protocol        = string
    ssl_policy      = optional(string, null)
    certificate_arn = optional(string, null)
    default_action = object({
      type             = optional(string, "forward")
      target_group_arn = optional(string, null)
      forward = object({
        target_group = list(object({
          target_group_arn = string
          weight           = optional(number, null)
        }))
        stickiness = optional(object({
          duration = optional(number, null)
          enabled  = optional(bool, null)
        }), null)
      })
    })
  }))
  description = <<EOF
  A list of objects that contains the configuration for the ALB listeners.
Current supported attributes are:
- alb_arn: The ARN of the ALB.
- port: The port on which the listener is listening.
- protocol: The protocol for connections from clients to the load balancer.
- ssl_policy: The security policy that defines which ciphers and protocols are
  supported. The default is the current predefined security policy.
- certificate_arn: The ARN of the certificate.
- default_action: The default action for the listener.
  EOF
  default     = null
}
