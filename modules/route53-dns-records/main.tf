resource "aws_route53_record" "alias" {
  for_each        = local.dns_alias_to_create
  zone_id         = each.value["is_zone_lookup_by_zone_name_enabled"] ? data.aws_route53_zone.lookup_for_zone_name[each.key].zone_id : data.aws_route53_zone.lookup_for_zone_id[each.key].zone_id
  name            = each.value["name"]
  allow_overwrite = each.value["allow_overwrite"]
  type            = "A"

  alias {
    name                   = lookup(each.value["alias"], "name")
    zone_id                = lookup(each.value["alias"], "zone_id")
    evaluate_target_health = lookup(each.value["alias"], "evaluate_target_health")
  }
}

resource "aws_route53_record" "www_record" {
  for_each        = { for k, v in local.dns_alias_to_create : k => v if v["is_www_enabled"] }
  name            = format("%s.%s", "www", each.value["name"])
  type            = "CNAME"
  ttl             = each.value["ttl"]
  records         = [aws_route53_record.alias[each.key].fqdn]
  allow_overwrite = each.value["allow_overwrite"]

  zone_id = each.value["is_zone_lookup_by_zone_name_enabled"] ? data.aws_route53_zone.lookup_for_zone_name[each.key].zone_id : data.aws_route53_zone.lookup_for_zone_id[each.key].zone_id
}
