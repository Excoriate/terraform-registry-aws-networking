output "is_enabled" {
  value       = var.is_enabled
  description = "Whether the module is enabled or not."
}

output "aws_region_for_deploy_this" {
  value       = local.aws_region_to_deploy
  description = "The AWS region where the module is deployed."
}

output "tags_set" {
  value       = var.tags
  description = "The tags set for the module."
}

/*
-------------------------------------
Custom outputs
-------------------------------------
*/
output "vpc" {
  value       = aws_vpc.this
  description = "VPC object."
}

output "subnet_public" {
  value       = aws_subnet.public
  description = "Public subnet objects."
}

output "subnet_private" {
  value       = aws_subnet.private
  description = "Private subnet objects."
}

output "route_table_public" {
  value       = aws_route_table.public
  description = "Public route table objects."
}

output "route_table_private" {
  value       = aws_route_table.private
  description = "Private route table objects."
}

output "vpc_id" {
  value       = join("", [for vpc in aws_vpc.this : vpc.id])
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = join("", [for vpc in aws_vpc.this : vpc.cidr_block])
  description = "The CIDR block of the VPC."
}

output "vpc_default_network_acl_id" {
  value       = join("", [for vpc in aws_vpc.this : vpc.default_network_acl_id])
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = join("", [for vpc in aws_vpc.this : vpc.default_route_table_id])
  description = "The ID of the route table created by default on VPC creation."
}

output "vpc_default_security_group_id" {
  value       = join("", [for vpc in aws_vpc.this : vpc.default_security_group_id])
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_dhcp_options_id" {
  value       = join("", [for vpc in aws_vpc.this : vpc.dhcp_options_id])
  description = "The ID of the set of DHCP options you've associated with the VPC."
}

output "vpc_instance_tenancy" {
  value       = join("", [for vpc in aws_vpc.this : vpc.instance_tenancy])
  description = "A tenancy option for instances launched into the VPC."
}

output "subnet_public_ids" {
  value       = join(",", [for subnet in aws_subnet.public : subnet.id])
  description = "The IDs of the public subnets."
}

output "subnet_public_cidr_blocks" {
  value       = join(",", [for subnet in aws_subnet.public : subnet.cidr_block])
  description = "The CIDR blocks of the public subnets."
}

output "subnet_public_availability_zones" {
  value       = join(",", [for subnet in aws_subnet.public : subnet.availability_zone])
  description = "The availability zones of the public subnets."
}

output "subnet_public_map_public_ip_on_launch" {
  value       = join(",", [for subnet in aws_subnet.public : subnet.map_public_ip_on_launch])
  description = "Whether instances launched in these subnets get public IP addresses."
}

output "subnet_private_ids" {
  value       = join(",", [for subnet in aws_subnet.private : subnet.id])
  description = "The IDs of the private subnets."
}

output "subnet_private_cidr_blocks" {
  value       = join(",", [for subnet in aws_subnet.private : subnet.cidr_block])
  description = "The CIDR blocks of the private subnets."
}

output "subnet_private_availability_zones" {
  value       = join(",", [for subnet in aws_subnet.private : subnet.availability_zone])
  description = "The availability zones of the private subnets."
}

output "subnet_private_map_public_ip_on_launch" {
  value       = join(",", [for subnet in aws_subnet.private : subnet.map_public_ip_on_launch])
  description = "Whether instances launched in these subnets get public IP addresses."
}


output "route_table_public_ids" {
  value       = join(",", [for route_table in aws_route_table.public : route_table.id])
  description = "The IDs of the public route tables."
}

output "route_table_private_ids" {
  value       = join(",", [for route_table in aws_route_table.private : route_table.id])
  description = "The IDs of the private route tables."
}
