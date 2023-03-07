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
variable "vpc_data" {
  type = object({
    name                      = string
    subnet_public_identifier  = optional(string, "public")
    subnet_private_identifier = optional(string, "private")
    retrieve_subnets          = optional(bool, false)
    retrieve_subnets_private  = optional(bool, false)
    retrieve_subnets_public   = optional(bool, false)
    filter_by_az              = optional(bool, false)
  })
  description = <<EOF
A set of options to perform lookup and search over AWS configured network components. The allowed
filters and/or search criteria are:
  - name                     : The name of the VPC to search for.
  - subnet_public_identifier : The identifier of the public subnet to search for.
  - subnet_private_identifier: The identifier of the private subnet to search for.
  - retrieve_subnets         : Whether to retrieve the subnets of the VPC.
  - retrieve_subnets_private : Whether to retrieve the private subnets of the VPC.
  - retrieve_subnets_public  : Whether to retrieve the public subnets of the VPC.
  - filter_by_az             : Whether to filter the subnets by availability zone.
  EOF
  default     = null
}

variable "dns_data" {
  type = object({
    domain                = string
    fetch_zone            = optional(bool, false)
    fetch_acm_certificate = optional(bool, false)
  })
  description = <<EOF
A set of options to perform lookup and search over AWS configured DNS components. The allowed
filters and/or search criteria are:
  - domain: The domain name to search for.
  - fetch_zone: Whether to fetch the zone data.
  - fetch_acm_certificate: Whether to fetch the ACM certificate data.
  EOF
  default     = null
}
