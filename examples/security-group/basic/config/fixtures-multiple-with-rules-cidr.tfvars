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
  }
]
