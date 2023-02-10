config {
  module = true
  force = false
}

plugin "aws" {
  enabled = true
  deep_check = true
  version = "0.21.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"
}

rule "terraform_module_pinned_source" {
  enabled = true
}

rule "aws_route_not_specified_target" {
  enabled = false
}

rule "aws_route_specified_multiple_targets" {
  enabled = false
}

rule "aws_security_group_invalid_protocol" {
  enabled = false
}

rule "aws_vpc_invalid_instance_tenancy" {
  enabled = false
}

rule "aws_route_invalid_egress_only_gateway" {
  enabled = false
}

rule "aws_route_invalid_gateway" {
  enabled = false
}

rule "aws_route_invalid_instance"{
  enabled = false
}

rule "aws_route_invalid_nat_gateway" {
  enabled = false
}

rule "aws_route_invalid_network_interface" {
  enabled = false
}

rule "aws_route_invalid_route_table" {
  enabled = false
}

rule "aws_route_invalid_vpc_peering_connection" {
  enabled = false
}
