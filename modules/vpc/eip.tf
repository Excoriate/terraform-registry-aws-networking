resource "aws_eip" "this" {
  count      = local.enable_creation
  vpc        = true
  depends_on = [aws_internet_gateway.this]
}
