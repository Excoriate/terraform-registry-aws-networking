data "aws_route53_zone" "lookup_for_zone_id" {
  for_each     = { for k, v in local.acm_zone_fetcher_to_create : k => v if v["fetch_by_zone_id"] }
  zone_id      = each.value["zone_id"]
  name         = null
  private_zone = each.value["is_private_zone"]
}

data "aws_route53_zone" "lookup_for_zone_name" {
  for_each     = { for k, v in local.acm_zone_fetcher_to_create : k => v if v["fetch_by_zone_name"] }
  zone_id      = null
  name         = each.value["zone_name"]
  private_zone = each.value["is_private_zone"]
}
