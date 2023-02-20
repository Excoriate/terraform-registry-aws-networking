locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
  */
  is_certificate_enabled = !var.is_enabled ? false : var.acm_certificate_config == null ? false : length(var.acm_certificate_config) != 0

  acm_cert_normalized = !local.is_certificate_enabled ? [] : [
    for cert in var.acm_certificate_config : {
      name        = lower(trimspace(cert["name"]))
      domain_name = lower(trimspace(cert["domain_name"]))
      subject_alternative_names = cert["subject_alternative_names"] == null ? [] : [
        for san in cert["subject_alternative_names"] : lower(trimspace(san)) if length(san) > 0
      ]
      certificate_transparency_logging_preference = cert["certificate_transparency_logging_preference"]
      validation_config = cert["validation_config"] == null ? {} : {
        zone_id         = cert["validation_config"]["zone_id"] == null ? null : cert["validation_config"]["zone_id"]
        zone_name       = cert["validation_config"]["zone_name"] == null ? null : cert["validation_config"]["zone_name"]
        is_private_zone = cert["validation_config"]["is_private_zone"] == null ? false : cert["validation_config"]["is_private_zone"]
        ttl             = cert["validation_config"]["ttl"] == null ? 300 : cert["validation_config"]["ttl"]
      }

      wait_for_certificate_issued = cert["wait_for_certificate_issued"]

      // feature flags
      is_validation_enabled                  = cert["validation_config"] != null
      is_validation_looking_up_for_zone_id   = cert["validation_config"] == null ? false : cert["validation_config"]["zone_id"] != null
      is_validation_looking_up_for_zone_name = cert["validation_config"] == null ? false : cert["validation_config"]["zone_name"] == null ? false : cert["validation_config"]["zone_name"] != null && cert["validation_config"]["zone_id"] == null
    }
  ]

  /*
   - 'acm_cert_to_create' -> this object is mainly used to generate the ACM certificate resources.
   - 'acm_cert_to_validate' -> this object is mainly used to generate the ACM certificate validation resources.
  */
  acm_cert_to_create = !local.is_certificate_enabled ? {} : { for cert in local.acm_cert_normalized : cert["name"] => cert }
  acm_cert_to_validate = !local.is_certificate_enabled ? {} : { for cert in local.acm_cert_normalized : cert["name"] => {
    name                                   = cert["name"]
    zone_id                                = cert["is_validation_looking_up_for_zone_id"] ? data.aws_route53_zone.lookup_for_zone_id[cert["name"]].zone_id : data.aws_route53_zone.lookup_for_zone_name[cert["name"]].zone_id
    domain_validation_options_set          = toset([for dvo in aws_acm_certificate.this : dvo.domain_validation_options])
    is_validation_looking_up_for_zone_id   = cert["is_validation_looking_up_for_zone_id"]
    is_validation_looking_up_for_zone_name = cert["is_validation_looking_up_for_zone_name"]
  } if cert["is_validation_enabled"] }
}
