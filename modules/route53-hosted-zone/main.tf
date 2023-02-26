/*
  1. Normal hosted zone.
    It doesn't require NS records.
*/
resource "aws_route53_zone" "hosted_zone" {
  for_each          = local.hosted_zone_config_to_create
  name              = each.value["name"]
  comment           = each.value["comment"]
  force_destroy     = each.value["force_destroy"]
  delegation_set_id = each.value["is_vpc_config_enabled"] ? null : each.value["delegation_set_id"]

  dynamic "vpc" {
    for_each = each.value["is_vpc_config_enabled"] ? each.value["vpc"] : {}
    content {
      vpc_id     = vpc.value["vpc_id"]
      vpc_region = vpc.value["vpc_region"]
    }
  }
}

resource "aws_route53_record" "hosted_zone_stand_alone_name_servers" {
  for_each = local.hosted_zone_stand_alone_name_servers_to_create
  zone_id  = aws_route53_zone.hosted_zone[each.key].zone_id
  name     = each.value["name"]
  type     = "NS"
  ttl      = each.value["ttl"]
  records  = each.value["records"]
}

/*
  2. Subdomains.
    - It requires NS records.
    - It requires a N number of child-zones, which'll act as subdomains
*/
resource "aws_route53_zone" "hosted_zone_subdomain_parent" {
  count             = local.subdomains_parent_to_create == null ? 0 : 1
  name              = lookup(local.subdomains_parent_to_create, "name")
  comment           = lookup(local.subdomains_parent_to_create, "comment")
  force_destroy     = lookup(local.subdomains_parent_to_create, "force_destroy")
  delegation_set_id = lookup(local.subdomains_parent_to_create, "is_vpc_config_enabled") ? null : lookup(local.subdomains_parent_to_create, "delegation_set_id")

  dynamic "vpc" {
    for_each = lookup(local.subdomains_parent_to_create, "is_vpc_config_enabled") ? lookup(local.subdomains_parent_to_create, "vpc") : {}
    content {
      vpc_id     = vpc.value["vpc_id"]
      vpc_region = vpc.value["vpc_region"]
    }
  }
}

resource "aws_route53_zone" "hosted_zone_subdomain_child" {
  for_each          = { for k, v in local.subdomains_childs_to_create : k => v }
  name              = each.value["subdomain"]
  comment           = each.value["comment"]
  force_destroy     = each.value["force_destroy"]
  delegation_set_id = each.value["is_vpc_config_enabled"] ? null : each.value["delegation_set_id"]

  dynamic "vpc" {
    for_each = each.value["is_vpc_config_enabled"] ? each.value["vpc_config"] : {}
    content {
      vpc_id     = vpc.value["vpc_id"]
      vpc_region = vpc.value["vpc_region"]
    }
  }
}

resource "aws_route53_record" "subdomain_ns_records" {
  for_each = { for k, v in local.subdomains_childs_to_create : k => v }
  zone_id  = aws_route53_zone.hosted_zone_subdomain_parent[0].zone_id // It's always 1 resource.
  name     = each.value["subdomain"]
  type     = "NS"
  ttl      = each.value["ttl"]
  records  = aws_route53_zone.hosted_zone_subdomain_child[each.value["subdomain"]].name_servers
}
