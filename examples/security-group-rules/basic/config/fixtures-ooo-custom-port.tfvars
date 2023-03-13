aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name    = "sg-1"
    sg_name = "stack-test-alb-sg"
  }
]

security_group_rules_ooo = [
  {
    name        = "sg-1"
    sg_name     = "stack-test-alb-sg"
    custom_port = 3223
  }
]
