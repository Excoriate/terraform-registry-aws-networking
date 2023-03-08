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
variable "target_group_config" {
  type = list(object({
    name                          = string
    port                          = number
    protocol                      = optional(string, "TCP")
    protocol_version              = optional(string, "HTTP1")
    slow_start                    = optional(number, 30)
    deregistration_delay          = optional(number, 15)
    load_balancing_algorithm_type = optional(string, "round_robin")
    target_type                   = optional(string, "ip")
    vpc_id                        = string
    health_check = optional(object({
      enabled             = bool
      path                = string
      port                = number
      protocol            = string
      timeout             = number
      interval            = number
      healthy_threshold   = number
      unhealthy_threshold = number
      matcher             = string
    }), null)
    stickiness = optional(object({
      enabled         = bool
      type            = string
      cookie_duration = number
    }), null)
  }))
  description = <<EOF
A configuration object that allows the creation of multiple target groups, of type 'alb'. The support values are:
- name: The name of the target group. This name must be unique per region per account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen.
- port: The port on which the targets are listening. Not used if the target is a Lambda function.
- protocol: The protocol to use for routing traffic to the targets. The default is the HTTP protocol.
- protocol_version: The protocol version. The possible values are GRPC, HTTP1, HTTP2. The default is HTTP1.
- slow_start: The time period, in seconds, during which the load balancer shifts traffic from the old target to the new target. During this time, the load balancer sends both new and old targets a proportional share of the traffic. After the time period ends, the load balancer shifts all traffic to the new target. The default is 30 seconds.
- deregistration_delay: The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default is 15 seconds.
- load_balancing_algorithm_type: The load balancing algorithm determines how the load balancer selects targets when routing requests. The value is round_robin or least_outstanding_requests. The default is round_robin.
- target_type: The type of target that you must specify when registering targets with this target group. The possible values are instance (targets are specified by instance ID) or ip (targets are specified by IP address). The default is ip.
- vpc_id: The ID of the VPC for the targets.
- health_check: An object that contains information about the health checks that Amazon performs on the targets in the target group. The object has the following attributes:
  - enabled: Indicates whether health checks are enabled. The default is true.
  - path: The destination for the health check request.
  - port: The port to use to connect with the target.
  - protocol: The protocol to use to connect with the target. The default is the HTTP protocol.
  - timeout: The amount of time, in seconds, during which no response means a failed health check. The default is 5 seconds. The range is 2-120 seconds.
  - interval: The approximate amount of time, in seconds, between health checks of an individual target. The default is 30 seconds. The range is 5-300 seconds.
  - healthy_threshold: The number of consecutive health checks successes required before considering an unhealthy target healthy. The default is 5. The range is 2-10.
  - unhealthy_threshold: The number of consecutive health check failures required before considering a target unhealthy. The default is 2. The range is 2-10.
  - matcher: The HTTP codes to use when checking for a successful response from a target. The default is 200.
- stickiness: An object that contains information about the stickiness settings. The object has the following attributes:
  - enabled: Indicates whether sticky sessions are enabled. The default is false.
  - type: The type of sticky sessions. The possible values are lb_cookie or application_cookie.
  - cookie_duration: The time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds).
EOF
  default     = null
}
