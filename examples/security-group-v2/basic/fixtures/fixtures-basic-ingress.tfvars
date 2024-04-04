security_group_config = {
  name        = "sg-basic-ingress"
  description = "Security Group with a basic TCP ingress rule"
  vpc_id      = "vpc-04eaef44d62c5b7a6"
  ingress = [
    {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = []
}

is_enabled = true
