data "aws_security_group" "sg_by_name" {
  for_each = { for k, v in local.sg_create : k => v if v["lookup_by_name_enabled"] && !v["lookup_by_id_enabled"] }
  name     = each.value["sg_name"]
}

data "aws_security_group" "sg_by_id" {
  for_each = { for k, v in local.sg_create : k => v if v["lookup_by_id_enabled"] }
  id       = each.value["sg_id"]
}
