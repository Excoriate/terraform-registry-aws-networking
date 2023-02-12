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

security_group_rules = [
  {
    sg_parent   = "firewall-test-1"
    type        = "ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    sg_parent   = "firewall-test-1"
    type        = "ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    sg_parent   = "firewall-test-1"
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    sg_parent   = "firewall-test-1"
    type        = "egress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

vpc_lookup_config = {
  vpc_name = "tsn-sandbox-us-east-1-network-core-cross-vpc-backbone"
}
