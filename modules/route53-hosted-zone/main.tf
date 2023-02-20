resource "aws_route53_zone" "this" {
  for_each = local.zone_config_to_create
  name     = each.value["name"]

  dynamic "vpc" {
    for_each = each.value["is_vpc_config_enabled"] ? each.value["vpc"] : {}
    content {
      vpc_id     = vpc.value["vpc_id"]
      vpc_region = vpc.value["vpc_region"]
    }
  }
}

resource "aws_route53_record" "this" {
  for_each = local.zone_subdomains_to_create
  zone_id  = aws_route53_zone.this[each.value["name"]]["id"]
  name     = each.value["subdomain"]
  type     = "NS"
  ttl      = each.value["ttl"]
  records  = each.value["name_servers"]
}
