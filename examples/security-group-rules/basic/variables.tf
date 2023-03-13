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
    // Identifiers
    name    = string                 // Friendly name.
    sg_name = string                 // Security group name to check.
    sg_id   = optional(string, null) // Security group id to check.
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for the security groups. This object aims
to configure a lookup operation for an existing security group, either looking up by
its 'id' or by its 'name'. The following attributes are supported:
- name: Friendly name for each resource. Act as a terraform identifier.
- sg_name: The name of the security group.
- sg_id: The id of the security group.
  If the sg_id is passed, it'll take precedence over the sg_name.
  EOF
}

variable "security_group_rules_ooo" {
  type = list(object({
    // Identifiers
    name                               = string                 // Friendly name.
    sg_name                            = string                 // Security group name to check.
    sg_id                              = optional(string, null) // Security group id to check.
    source_security_group_id           = optional(string, null)
    enable_inbound_all_traffic         = optional(bool, false)
    enable_inbound_all_http            = optional(bool, false)
    enable_inbound_all_https           = optional(bool, false)
    enable_inbound_all_https_from_sg   = optional(bool, false)
    enable_inbound_all_http_from_sg    = optional(bool, false)
    enable_inbound_all_traffic_from_sg = optional(bool, false)
    enable_outbound_all_traffic        = optional(bool, false)
    enable_outbound_all_traffic_to_sg  = optional(bool, false)
    enable_outbound_all_http           = optional(bool, false)
    enable_outbound_all_http_to_sg     = optional(bool, false)
    enable_outbound_all_https          = optional(bool, false)
    enable_outbound_all_https_to_sg    = optional(bool, false)
    cidr_blocks                        = optional(list(string), null)
    custom_port                        = optional(number, null)
  }))
  default     = null
  description = <<EOF
A set of out-of-the-box rules to be applied to the security group. The following attributes are supported:
- name: Friendly name for each resource. Act as a terraform identifier.
- sg_name: The name of the security group.
- sg_id: The id of the security group.
- source_security_group_id: The ID of the security group to allow access from.
- enable_inbound_all_traffic: Whether to allow all inbound traffic.
- enable_inbound_all_http: Whether to allow all inbound HTTP traffic.
- enable_inbound_all_https: Whether to allow all inbound HTTPS traffic.
- enable_inbound_all_https_from_sg: Whether to allow all inbound HTTPS traffic from the security group itself.
- enable_inbound_all_http_from_sg: Whether to allow all inbound HTTP traffic from the security group itself.
- enable_inbound_all_traffic_from_sg: Whether to allow all inbound traffic from the security group itself.
- enable_outbound_all_traffic: Whether to allow all outbound traffic.
- enable_outbound_all_traffic_to_sg: Whether to allow all outbound traffic to the security group itself.
- enable_outbound_all_http: Whether to allow all outbound HTTP traffic.
- enable_outbound_all_http_to_sg: Whether to allow all outbound HTTP traffic to the security group itself.
- enable_outbound_all_https: Whether to allow all outbound HTTPS traffic.
- enable_outbound_all_https_to_sg: Whether to allow all outbound HTTPS traffic to the security group itself.
- cidr_blocks: The CIDR blocks to allow access from.
- custom_port: The custom port to allow access from.
  EOF
}

variable "security_group_rules" {
  type = list(object({
    name                     = string
    sg_name                  = string                 // Security group name to check.
    sg_id                    = optional(string, null) // Security group id to check.
    type                     = optional(string, "ingress")
    from_port                = number
    to_port                  = number
    protocol                 = optional(string, "tcp")
    cidr_blocks              = optional(list(string), null)
    ipv6_cidr_blocks         = optional(list(string), null)
    prefix_list_ids          = optional(list(string), null)
    self                     = optional(bool, false)
    description              = optional(string, "No description was set for this security group rule")
    source_security_group_id = optional(string, null)
  }))
  description = <<EOF
  A list of objects that contains the configuration for the security groups.
If set, it'll relate the sg_name with the 'name' attribute passed into the
variable 'security_group_config'. The following attributes are supported:
- sg_parent: The name of the security group.
- type: The type of the security group rule. Valid values are: ingress, egress.
- from_port: The start port of the security group rule.
- to_port: The end port of the security group rule.
- protocol: The protocol of the security group rule. Valid values are: tcp, udp, icmp, all.
- cidr_blocks: The CIDR blocks to allow access from.
- ipv6_cidr_blocks: The IPv6 CIDR blocks to allow access from.
- prefix_list_ids: The prefix list IDs to allow access from.
- self: Whether to allow access from the security group itself.
- description: The description of the security group rule.
- source_security_group_id: The ID of the security group to allow access from.
  EOF
  default     = null
}
