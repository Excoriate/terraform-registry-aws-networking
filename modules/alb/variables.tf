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
variable "alb_config" {
  type = list(object({
    name                             = string
    is_internal                      = optional(bool, false)
    enable_deletion_protection       = optional(bool, false)
    subnets_public                   = optional(list(string), [])
    security_groups                  = optional(list(string), [])
    enable_http2                     = optional(bool, false)
    enable_cross_zone_load_balancing = optional(bool, false)
    access_logs = optional(object({
      bucket = string
      prefix = optional(string, "")
    }), null)
  }))
  description = <<EOF
  A list of objects that contains the configuration for the ALB.
The following attributes are supported for each object:
- name: The name of the ALB.
- is_internal: Whether the ALB is internal. If true, it will be deployed in private subnets.
- enable_deletion_protection: Whether to enable deletion protection on the ALB.
- subnets_public: A list of public subnets IDs where the ALB will be deployed.
- security_groups: A list of security group IDs to assign to the ALB.
- enable_http2: Whether to enable HTTP/2.
- enable_cross_zone_load_balancing: Whether to enable cross-zone load balancing.
- access_logs: An object that contains the configuration for access logs. The following attributes are supported:
  - bucket: The name of the S3 bucket for the access logs.
  - prefix: (Optional) The prefix for the location in the S3 bucket. If not specified, the ALB name will be used.
EOF
  default     = null
}
