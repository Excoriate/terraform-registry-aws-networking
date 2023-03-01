aws_region = "us-east-1"
is_enabled = true

acm_certificate_config = [
  {
    name                        = "acm-cert-test-2"
    domain_name                 = "dummy.com"
    wait_for_certificate_issued = true
    validation_config = {
      name      = "acm-cert-test-2"
      zone_name = "dummy.com"
    }
  }
]

acm_validation_config = [
  {
    name        = "acm-cert-test-2"
    zone_name   = "dummy.com"
    domain_name = "dummy.com"
  }
]
