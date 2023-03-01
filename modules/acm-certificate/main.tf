resource "aws_acm_certificate" "this" {
  for_each                  = local.acm_cert_to_create
  domain_name               = each.value["domain_name"]
  validation_method         = "DNS"
  subject_alternative_names = each.value["subject_alternative_names"]

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  for_each                = local.acm_validation_to_create
  certificate_arn         = aws_acm_certificate.this[each.value["name"]].arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

resource "aws_route53_record" "this" {
  for_each        = local.acm_validation_to_create
  zone_id         = each.value["zone_id"]
  ttl             = each.value["ttl"]
  allow_overwrite = true
  name            = each.value["dvo"][each.value["domain_name"]]["name"]
  type            = each.value["dvo"][each.value["domain_name"]]["type"]
  records         = each.value["dvo"][each.value["domain_name"]]["records"]
}
