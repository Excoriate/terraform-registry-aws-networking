security_group_config = {
  name        = "simple-sg"
  description = "A simple security group with no ingress or egress rules"
  vpc_id      = "vpc-04eaef44d62c5b7a6"
  ingress     = []
  egress      = []
}

is_enabled = true
