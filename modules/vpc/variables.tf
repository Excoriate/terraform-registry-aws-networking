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
variable "vpc_config" {
  type = object({
    enable_dns_hostnames = optional(bool, true)
    enable_dns_support   = optional(bool, true)
    instance_tenancy     = optional(string, "default")
    cidr_block           = optional(string, "10.0.0.0/20")
  })
  default     = null
  description = <<EOF
Configuration object to set common VPC options. Options currently supported:
- enable_dns_hostnames: Whether to enable DNS hostnames in the VPC. Defaults to true.
- enable_dns_support: Whether to enable DNS support in the VPC. Defaults to true.
- instance_tenancy: The allowed tenancy of instances launched into the VPC. Defaults to 'default'.
- cidr_block: The CIDR block for the VPC.
EOF
}

variable "subnet_config" {
  type = object({
    map_public_ip_on_launch_subnet_public  = optional(bool, true)
    map_public_ip_on_launch_subnet_private = optional(bool, false)
    availability_zones_limit               = optional(number, 3)
  })
  default     = null
  description = <<EOF
Configuration object to set common subnet options. Options currently supported:
- map_public_ip_on_launch_subnet_public: Whether to map public IP on launch for public subnets. Defaults to true.
- map_public_ip_on_launch_subnet_private: Whether to map public IP on launch for private subnets. Defaults to false.
- availability_zones_limit: The number of availability zones to use. Defaults to 3.
EOF
}
