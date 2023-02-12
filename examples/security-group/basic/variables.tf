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

variable "security_group_rules_ooo" {
  type = list(object({
    sg_parent                              = string
    enable_all_inbound_traffic             = optional(bool, false)
    enable_all_inbound_traffic_from_source = optional(bool, false)
    enable_inbound_http                    = optional(bool, false)
    enable_inbound_http_from_source        = optional(bool, false)
    enable_inbound_https                   = optional(bool, false)
    enable_inbound_https_from_source       = optional(bool, false)
    enable_inbound_ssh_from_anywhere       = optional(bool, false)
    enable_inbound_ssh_from_source         = optional(bool, false)
    enable_inbound_icmp_from_source        = optional(bool, false)
    enable_inbound_icmp_from_anywhere      = optional(bool, false)
    enable_inbound_mysql_from_source       = optional(bool, false)
    enable_outbound_http                   = optional(bool, false)
    enable_outbound_http_to_source         = optional(bool, false)
    enable_outbound_https                  = optional(bool, false)
    enable_outbound_https_to_source        = optional(bool, false)
    enable_all_outbound_traffic            = optional(bool, false)
    enable_all_outbound_traffic_to_source  = optional(bool, false)
    source_security_group_id               = optional(string, null)
  }))
  description = <<EOF
  A list of objects that contains the configuration for the security groups, and that normally
used in the context of ALB, testing traffic for ICMP packages, and other common use-cases
It can be used as an alternative of the values that are set in the variable 'security_group_rules'.
If set, it'll relate the sg_name with the 'name' attribute passed into the
variable 'security_group_config'. The following attributes are supported:
- sg_parent: The name of the security group.
- enable_all_inbound_traffic: Whether to enable all inbound traffic or not.
- enable_all_inbound_traffic_from_source: Whether to enable all inbound traffic from a specific source or not.
- enable_inbound_http: Whether to enable inbound HTTP traffic or not.
- enable_inbound_http_from_source: Whether to enable inbound HTTP traffic from a specific source or not.
- enable_inbound_https: Whether to enable inbound HTTPS traffic or not.
- enable_inbound_https_from_source: Whether to enable inbound HTTPS traffic from a specific source or not.
- enable_inbound_ssh_from_anywhere: Whether to enable inbound SSH traffic from anywhere or not.
- enable_inbound_ssh_from_source: Whether to enable inbound SSH traffic from a specific source or not.
- enable_inbound_icmp_from_source: Whether to enable inbound ICMP traffic from a specific source or not.
- enable_inbound_icmp_from_anywhere: Whether to enable inbound ICMP traffic from anywhere or not.
- enable_inbound_mysql_from_source: Whether to enable inbound MySQL traffic from a specific source or not.
- enable_outbound_http: Whether to enable outbound HTTP traffic or not.
- enable_outbound_http_to_source: Whether to enable outbound HTTP traffic to a specific source or not.
- enable_outbound_https: Whether to enable outbound HTTPS traffic or not.
- enable_outbound_https_to_source: Whether to enable outbound HTTPS traffic to a specific source or not.
- enable_all_outbound_traffic: Whether to enable all outbound traffic or not.
- enable_all_outbound_traffic_to_source: Whether to enable all outbound traffic to a specific source or not.
- source_security_group_id: The ID of the source security group.
  EOF
  default     = null
}
