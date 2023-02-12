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
variable "security_group_config" {
  type = list(object({
    name        = string
    description = optional(string, null)
    vpc_id      = optional(string, null)
  }))
  description = <<EOF
  A list of objects that contains the configuration for the security groups.
This configuration includes the main configuration for the security group. The following
attributes are supported:
- name: The name of the security group.
- description: The description of the security group.
- vpc_id: The VPC ID to create the security group in.
  EOF
  default     = null
}

variable "security_group_rules" {
  type = list(object({
    sg_parent        = string
    type             = string
    from_port        = number
    to_port          = number
    protocol         = string
    cidr_blocks      = optional(list(string), null)
    ipv6_cidr_blocks = optional(list(string), null)
    prefix_list_ids  = optional(list(string), null)
    self             = optional(bool, false)
    description      = optional(string, "no description")
  }))
  description = <<EOF
  A list of objects that contains the configuration for the security groups.
If set, it'll relate the sg_name with the 'name' attribute passed into the
variable 'security_group_config'. The following attributes are supported:
- sg_parent: The name of the security group.
- sg_rules: An object that contains the configuration for the security group rules.
  EOF
  default     = null
}

variable "vpc_lookup_config" {
  type = object({
    vpc_name               = optional(string, null)
    is_default_vpc_enabled = optional(bool, false)
  })
  description = <<EOF
This object works in ocnjunction with the variable 'security_group_config' to
lookup the VPC ID to create the security group in. The following attributes are supported:
- vpc_name: The name of the VPC to lookup.
- is_default_vpc_enabled: Whether to lookup the default VPC or not.
  EOF
  default     = null
}
