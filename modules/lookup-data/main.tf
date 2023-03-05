data "aws_vpc" "this" {
  for_each = local.vpc_data_fetch
  filter {
    name   = "tag:Name"
    values = [each.value["vpc_name"]]
  }

  default = false
}


data "aws_subnet_ids" "subnets_private" {
  for_each = local.subnet_private_fetch
  vpc_id   = data.aws_vpc.this[each.value["vpc_name"]].id

  filter {
    name   = "tag:Name"
    values = [each.value["identifier"]]
  }

  depends_on = [
    data.aws_vpc.this
  ]
}

data "aws_subnet_ids" "subnets_public" {
  for_each = local.subnet_public_fetch
  vpc_id   = data.aws_vpc.this[each.value["vpc_name"]].id

  filter {
    name   = "tag:Name"
    values = [each.value["identifier"]]
  }

  depends_on = [
    data.aws_vpc.this
  ]
}


data "aws_subnet_ids" "all_subnet_ids" {
  for_each = local.subnet_all_fetch
  vpc_id   = data.aws_vpc.this[each.value["vpc_name"]].id

  depends_on = [
    data.aws_vpc.this
  ]
}

data "aws_subnet" "all_subnets" {
  for_each = values({ for k, v in data.aws_subnet_ids.all_subnet_ids : k => v["ids"] })[0]
  id       = each.value

  depends_on = [
    data.aws_subnet_ids.all_subnet_ids
  ]
}
