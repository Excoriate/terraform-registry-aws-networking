aws_region = "us-east-1"
is_enabled = true

security_group_config = [
  {
    name        = "firewall-test-1"
    description = "my sg that i am testing"
    vpc_id      = "vpc-1234567890"
  }
]


vpc_lookup_config = {
  vpc_name = "tsn-sandbox-us-east-1-network-core-cross-vpc-backbone"
}
