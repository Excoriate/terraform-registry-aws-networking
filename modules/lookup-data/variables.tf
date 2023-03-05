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
  })
  description = <<EOF
  EOF
  default     = null
}
