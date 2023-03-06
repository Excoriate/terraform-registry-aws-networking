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

/*
  Subnets per AZ.
  - The first datasource obtains the IDs
  - The second datasource obtains the subnet data
*/
// 1. AZ 1a
data "aws_subnet_ids" "subnets_public_by_az_1a" {
  for_each = local.subnet_public_fetch_by_az
  vpc_id   = data.aws_vpc.this[each.value["vpc_name"]].id

  filter {
    name   = "tag:Name"
    values = [each.value["identifier"]]
  }

  filter {
    name   = "availability-zone"
    values = [format("%s%s", var.aws_region, "a")]
  }

  depends_on = [
    data.aws_vpc.this
  ]
}

data "aws_subnet" "subnets_public_by_az_1a" {
  for_each = length(keys(local.subnet_public_fetch_by_az)) > 0 ? values({ for k, v in data.aws_subnet_ids.subnets_public_by_az_1a : k => v["ids"] })[0] : null
  id       = each.value

  depends_on = [
    data.aws_subnet_ids.subnets_public_by_az_1a
  ]
}

// 2. AZ 1b
data "aws_subnet_ids" "subnets_public_by_az_1b" {
  for_each = local.subnet_public_fetch_by_az
  vpc_id   = data.aws_vpc.this[each.value["vpc_name"]].id

  filter {
    name   = "tag:Name"
    values = [each.value["identifier"]]
  }

  filter {
    name   = "availability-zone"
    values = [format("%s%s", var.aws_region, "b")]
  }

  depends_on = [
    data.aws_vpc.this
  ]
}

data "aws_subnet" "subnets_public_by_az_1b" {
  for_each = length(keys(local.subnet_public_fetch_by_az)) > 0 ? values({ for k, v in data.aws_subnet_ids.subnets_public_by_az_1b : k => v["ids"] })[0] : null
  id       = each.value

  depends_on = [
    data.aws_subnet_ids.subnets_public_by_az_1b
  ]
}

// 3. AZ 1c
data "aws_subnet_ids" "subnets_public_by_az_1c" {
  for_each = local.subnet_public_fetch_by_az
  vpc_id   = data.aws_vpc.this[each.value["vpc_name"]].id

  filter {
    name   = "tag:Name"
    values = [each.value["identifier"]]
  }

  filter {
    name   = "availability-zone"
    values = [format("%s%s", var.aws_region, "c")]
  }

  depends_on = [
    data.aws_vpc.this
  ]
}

data "aws_subnet" "subnets_public_by_az_1c" {
  for_each = length(keys(local.subnet_public_fetch_by_az)) > 0 ? values({ for k, v in data.aws_subnet_ids.subnets_public_by_az_1c : k => v["ids"] })[0] : null
  id       = each.value

  depends_on = [
    data.aws_subnet_ids.subnets_public_by_az_1c
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
  for_each = length(keys(local.subnet_all_fetch)) > 0 ? values({ for k, v in data.aws_subnet_ids.all_subnet_ids : k => v["ids"] })[0] : {}
  id       = each.value

  depends_on = [
    data.aws_subnet_ids.all_subnet_ids
  ]
}
