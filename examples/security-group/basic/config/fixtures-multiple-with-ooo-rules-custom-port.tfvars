aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name        = "firewall-test-1"
    description = "my sg that i am testing"
    vpc_id      = "vpc-1234567890"
  },
  {
    name        = "firewall-test-2"
    description = "Another security group"
    vpc_id      = "vpc-1234567890"
  }
]

security_group_rules_ooo = [
  {
    sg_parent                             = "firewall-test-1"
    enable_inbound_from_custom_port_cidr  = true
    enable_outbound_from_custom_port_cidr = true
    custom_port                           = 9090
  }
]
