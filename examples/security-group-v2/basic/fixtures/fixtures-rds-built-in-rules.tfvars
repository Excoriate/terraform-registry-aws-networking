security_group_config = {
  name        = "sg-rds-builtin-rule"
  description = "Security Group with multiple rules"
  vpc_id      = "vpc-04eaef44d62c5b7a6"
  ingress = [
    {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  egress = [
    {
      description = "Allow traffic to port 3342"
      from_port   = 3342
      to_port     = 3342
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

rds_ingress_security_group_rule = {
  db_port = 3306
}

is_enabled = true
