security_group_config = {
  name        = "sg-self-ref"
  description = "Security Group with a self-referencing rule"
  vpc_id      = "vpc-04eaef44d62c5b7a6"
  ingress = [
    {
      description = "Allow internal traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      self        = true
    }
  ]
  egress = [
    {
      description = "Allow outbound traffic to specific CIDR"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}

is_enabled = true
