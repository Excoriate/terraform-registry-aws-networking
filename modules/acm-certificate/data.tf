data "aws_route53_zone" "lookup_for_zone_id" {
  for_each     = { for k, v in local.acm_cert_to_create : k => v if v["is_validation_enabled"] && v["is_validation_looking_up_for_zone_id"] }
  zone_id      = lookup(each.value["validation_config"], "zone_id")
  name         = null
  private_zone = lookup(each.value["validation_config"], "is_private_zone", false)
}

data "aws_route53_zone" "lookup_for_zone_name" {
  for_each     = { for k, v in local.acm_cert_to_create : k => v if v["is_validation_enabled"] && v["is_validation_looking_up_for_zone_name"] }
  zone_id      = null
  name         = lookup(each.value["validation_config"], "zone_name")
  private_zone = lookup(each.value["validation_config"], "is_private_zone", false)
}
