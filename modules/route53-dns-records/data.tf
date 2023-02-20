data "aws_route53_zone" "lookup_for_zone_id" {
  for_each     = { for k, v in local.dns_alias_to_create : k => v if v["is_zone_lookup_by_zone_id_enabled"] }
  zone_id      = each.value["zone_id"]
  name         = null
  private_zone = false
}

data "aws_route53_zone" "lookup_for_zone_name" {
  for_each     = { for k, v in local.dns_alias_to_create : k => v if v["is_zone_lookup_by_zone_name_enabled"] && !v["is_zone_lookup_by_zone_id_enabled"] }
  zone_id      = null
  name         = each.value["zone_name"]
  private_zone = false
}
