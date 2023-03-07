data "aws_acm_certificate" "this" {
  for_each = !local.fetch_dns_acm_enabled ? {} : local.dns_acm_fetch

  domain      = each.value["domain_name"]
  statuses    = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "this" {
  for_each = !local.fetch_dns_zone_enabled ? {} : local.dns_zone_fetch

  name         = each.value["domain_name"]
  private_zone = false
}
