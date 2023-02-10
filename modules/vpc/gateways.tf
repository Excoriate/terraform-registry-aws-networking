resource "aws_internet_gateway" "this" {
  count  = local.enable_creation
  vpc_id = local.vpc_id
  tags   = var.tags
}

resource "aws_nat_gateway" "this" {
  count         = local.enable_creation
  allocation_id = join("", [for ip in aws_eip.this : ip.id])
  subnet_id     = [for subnet in aws_subnet.public : subnet.id][0]
  depends_on    = [aws_internet_gateway.this]
  tags          = var.tags
}
