resource "aws_acm_certificate" "this" {
  for_each                  = local.acm_cert_to_create
  domain_name               = each.value["domain_name"]
  validation_method         = "DNS"
  subject_alternative_names = each.value["subject_alternative_names"]

  tags = var.tags
}

resource "aws_acm_certificate_validation" "this" {
  for_each                = local.acm_cert_to_validate
  certificate_arn         = aws_acm_certificate.this[each.value["name"]].arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

resource "aws_route53_record" "this" {
  for_each = { for dvo in local.acm_cert_to_validate : dvo["domain_name"] => {
    name   = dvo["resource_record_name"]
    type   = dvo["resource_record_type"]
    record = dvo["resource_record_value"]
  } }
  zone_id         = each.value["zone_id"]
  ttl             = each.value["ttl"]
  allow_overwrite = true
  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
}
