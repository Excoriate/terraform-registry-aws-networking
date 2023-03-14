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
variable "record_type_alias_config" {
  type = list(object({
    name            = string
    zone_name       = optional(string, null)
    zone_id         = optional(string, null)
    allow_overwrite = optional(bool, false)
    ttl             = optional(number, 30)
    alias_target_config = object({
      target_zone_id             = string
      target_dns_name            = string
      target_enable_health_check = optional(bool, false)
    })
  }))
  default     = null
  description = <<EOF
  A list of objects that contains the following attributes:
  - name: The name of the record.
  - zone_name: The name of the zone to contain this record.
  - zone_id: The ID of the zone to contain this record.
  - allow_overwrite: If true, any existing records with the same name and type will be overwritten.
If false, all existing records with the same name and type will be overwritten.
  - ttl: The TTL of the record.
  - alias_target_config: A object that contains the following attributes:
    - target_zone_id: The ID of the zone to contain the resource record set that you're
creating the alias for.
    - target_dns_name: The value that you specify depends on where you want to route
    - target_enable_health_check: If true, the alias resource record set inherits the health
EOF
}
