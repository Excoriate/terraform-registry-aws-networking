locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
   * Control flags are managed separately. This is to avoid the complexity of the control flags.
  */
  is_certificate_enabled            = !var.is_enabled ? false : var.acm_certificate_config == null ? false : length(var.acm_certificate_config) != 0
  is_certificate_validation_enabled = !var.is_enabled ? false : !local.is_certificate_enabled ? false : var.acm_validation_config == null ? false : length(var.acm_validation_config) != 0

  /*
   * ACM Certificate creation.
   * - Creates the ACM certificate.
   * - It doesn't consider validation.
  */
  acm_cert_normalised = !local.is_certificate_enabled ? [] : [
    for cert in var.acm_certificate_config : {
      name        = lower(trimspace(cert["name"]))
      domain_name = lower(trimspace(cert["domain_name"]))
      subject_alternative_names = cert["subject_alternative_names"] == null ? [] : [
        for san in cert["subject_alternative_names"] : lower(trimspace(san)) if length(san) > 0
      ]
      certificate_transparency_logging_preference = cert["certificate_transparency_logging_preference"]
      wait_for_certificate_issued                 = cert["wait_for_certificate_issued"]
    }
  ]

  acm_cert_to_create = !local.is_certificate_enabled ? {} : { for cert in local.acm_cert_normalised : cert["name"] => cert }

  /*
   * ACM Certificate validation.
   * - The validation is made through DNS.
   * - Conditionally manage the 'validation'-related resources.
  */
  acm_validation = !local.is_certificate_validation_enabled ? [] : [
    for validation in var.acm_validation_config : {
      name        = lower(trimspace(validation["name"]))
      domain_name = lower(trimspace(validation["domain_name"]))
      ttl         = validation["ttl"]
      zone_id     = validation["zone_name"] == null ? data.aws_route53_zone.lookup_for_zone_id[validation["name"]].zone_id : data.aws_route53_zone.lookup_for_zone_name[validation["name"]].zone_id
      dvo = {
        for dvo in aws_acm_certificate.this[validation["name"]].domain_validation_options : dvo["domain_name"] => {
          name    = dvo["resource_record_name"]
          type    = dvo["resource_record_type"]
          records = [dvo["resource_record_value"]]
        }
      }
    }
  ]

  acm_validation_to_create = !local.is_certificate_validation_enabled ? {} : { for validation in local.acm_validation : validation["name"] => validation }

  /*
   * ACM Zone fetcher-logic
   * - In order to avoid cycle-dependency between the required data sources and these locals, it was separated in a different object.
   * - This object only checks the zone for the validation object.
  */
  acm_zone_fetcher_normalised = !local.is_certificate_validation_enabled ? [] : [
    for validation in var.acm_validation_config : {
      name               = lower(trimspace(validation["name"]))
      is_private_zone    = validation["is_private_zone"]
      fetch_by_zone_name = validation["zone_name"] != null
      fetch_by_zone_id   = validation["zone_id"] != null
      zone_id            = validation["zone_id"]
      zone_name          = validation["zone_name"]
    }
  ]

  acm_zone_fetcher_to_create = !local.is_certificate_validation_enabled ? {} : { for validation in local.acm_zone_fetcher_normalised : validation["name"] => validation }
}
