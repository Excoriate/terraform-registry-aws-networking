resource "aws_route_table" "private" {
  count  = local.enable_creation
  vpc_id = local.vpc_id
  tags   = var.tags
}

resource "aws_route" "this" {
  count = local.enable_creation

  route_table_id         = join("", [for r in aws_route_table.private : r.id if r.id != ""])
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = join("", [for n in aws_nat_gateway.this : n.id if n.id != ""])
}

resource "aws_route_table_association" "private" {
  count = length(local.private_subnets_cidr_list)

  subnet_id      = element([for s in aws_subnet.private : s.id], count.index)
  route_table_id = join("", [for r in aws_route_table.private : r.id if r.id != ""])
}

resource "aws_route_table_association" "public" {
  count = length(local.public_subnets_cidr_list)

  subnet_id      = element([for s in aws_subnet.public : s.id], count.index)
  route_table_id = join("", [for r in aws_route_table.public : r.id if r.id != ""])
}

resource "aws_route_table" "public" {
  count  = local.enable_creation
  vpc_id = local.vpc_id
  tags   = var.tags
}

resource "aws_route" "public_internet_gateway" {
  count                  = local.enable_creation
  route_table_id         = join("", [for r in aws_route_table.public : r.id if r.id != ""])
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = join("", [for g in aws_internet_gateway.this : g.id if g.id != ""])
}
