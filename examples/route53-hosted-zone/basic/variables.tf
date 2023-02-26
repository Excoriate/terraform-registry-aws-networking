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
variable "hosted_zone_stand_alone" {
  type = list(object({
    name              = string
    comment           = optional(string, null)
    force_destroy     = optional(bool, false)
    delegation_set_id = optional(string, null)
    vpc = optional(object({
      vpc_id     = string
      vpc_region = string
    }), null)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for the hosted zones to be created.
  Each object must contain the following attributes:
  - name: The name of the hosted zone.
  - comment: (Optional) A comment for the hosted zone.
  - force_destroy: (Optional) Whether to destroy the hosted zone even if it contains records.
  - delegation_set_id: (Optional) The ID of the reusable delegation set to associate with the hosted zone.
  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the hosted zone.
    - vpc_id: The ID of the VPC to associate with the hosted zone.
    - vpc_region: The region of the VPC to associate with the hosted zone.
  - zone_delegation_config: (Optional) A map of attributes that contains the configuration for the opinionated hosted-zone delegation.
    - name_servers: A list of name servers to delegate the zone to.
    - child_zone_name: The name of the child zone to create.
EOF
}

variable "hosted_zone_subdomains_parent" {
  type = object({
    name              = string
    comment           = optional(string, null)
    force_destroy     = optional(bool, false)
    delegation_set_id = optional(string, null)
    vpc = optional(object({
      vpc_id     = string
      vpc_region = string
    }), null)
  })
  default     = null
  description = <<EOF
  An object that contains the configuration for the parent hosted zone to be created.
  The object must contain the following attributes:
  - name: The name of the hosted zone.
  - force_destroy: (Optional) Whether to destroy the hosted zone even if it contains records.
  - delegation_set_id: (Optional) The ID of the reusable delegation set to associate with the hosted zone.
  - comment: (Optional) A comment for the hosted zone.
  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the hosted zone.
    - vpc_id: The ID of the VPC to associate with the hosted zone.
    - vpc_region: The region of the VPC to associate with the hosted zone.
EOF
}

variable "hosted_zone_subdomains_childs" {
  type = list(object({
    domain            = string
    name              = string
    comment           = optional(string, null)
    force_destroy     = optional(bool, false)
    ttl               = optional(number, 90)
    delegation_set_id = optional(string, null)
    vpc = optional(object({
      vpc_id     = string
      vpc_region = string
    }), null)
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the configuration for the subdomains to be created.
  Each object must contain the following attributes:
  - domain: The domain of the subdomain.
  - name: The name of the subdomain.
  - comment: (Optional) A comment for the subdomain.
  - force_destroy: (Optional) Whether to destroy the subdomain even if it contains records.
  - ttl: (Optional) The TTL for the subdomain.
  - delegation_set_id: (Optional) The ID of the reusable delegation set to associate with the subdomain.
  - vpc: (Optional) A map of attributes that contains the configuration for the VPC to associate with the subdomain.
    - vpc_id: The ID of the VPC to associate with the subdomain.
    - vpc_region: The region of the VPC to associate with the subdomain.
EOF
}
