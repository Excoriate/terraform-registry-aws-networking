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
variable "acm_certificate_config" {
  type = list(object({
    name                                        = string
    domain_name                                 = string
    subject_alternative_names                   = optional(list(string), [])
    certificate_transparency_logging_preference = optional(string, "ENABLED")
    wait_for_certificate_issued                 = optional(bool, false)
    validation_config = optional(object({
      zone_id         = optional(string, null)
      zone_name       = optional(string, null) // it'll take precedence
      ttl             = optional(number, 300)
      is_private_zone = optional(bool, false)
    }))
  }))
  default     = null
  description = <<EOF
  A list of ACM certificate configurations. Each configuration is an object with the following attributes:
  - name: The name of the certificate. It will be used to name the ACM certificate resource.
  - domain_name: The domain name for which the certificate is requested.
  - subject_alternative_names: A list of additional FQDNs to be included in the Subject Alternative Name extension of the ACM certificate.
  - certificate_transparency_logging_preference: The certificate transparency logging preference. Valid values are ENABLED or DISABLED.
  - wait_for_certificate_issued: Whether to wait for the certificate to be issued or not.
  - validation_config: An object with the following attributes:
    - zone_id: The ID of the Route53 hosted zone to contain the validation record.
    - zone_name: The name of the Route53 hosted zone to contain the validation record. It'll take precedence over zone_id.
    - is_private_zone: Whether the Route53 hosted zone is private or not.
    - ttl (optional): The TTL of the validation record.
EOF
}
