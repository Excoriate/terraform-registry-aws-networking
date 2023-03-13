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
    name                        = "sg-1"
    sg_name                     = "stack-test-alb-sg"
    enable_inbound_all_traffic  = true
    enable_outbound_all_traffic = true
  }
]
