aws_region = "us-east-1"
is_enabled = true

acm_certificate_config = [
  {
    name                        = "acm-cert-test-2"
    domain_name                 = "example.com"
    wait_for_certificate_issued = true
  }
]
