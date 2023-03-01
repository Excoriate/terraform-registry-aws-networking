aws_region = "us-east-1"
is_enabled = true

acm_certificate_config = [
  {
    name                        = "acm-cert-test-2"
    domain_name                 = "4id.network"
    wait_for_certificate_issued = true
    validation_config = {
      name      = "acm-cert-test-2"
      zone_name = "4id.network"
    }
  }
]

acm_validation_config = [
  {
    name        = "acm-cert-test-2"
    zone_name   = "4id.network"
    domain_name = "4id.network"
  }
]
