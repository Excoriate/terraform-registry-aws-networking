<!-- BEGIN_TF_DOCS -->
# ☁️ AWS VPC modul
## Description

This module creates a VPC with the following resources:
* 🚀 Main VPC.
* 🚀 Public subnets.
* 🚀 Private subnets.
* 🚀 Internet gateway.
* 🚀 NAT gateway.
* 🚀 Route tables.
* 🚀 Security groups.

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/default"
  is_enabled = var.is_enabled
  aws_region = var.aws_region
}
```

For module composition, It's recommended to take a look at the module's `outputs` to understand what's available:
```hcl
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
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.52.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.tis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_subnet_config"></a> [subnet\_config](#input\_subnet\_config) | Configuration object to set common subnet options. Options currently supported:<br>- map\_public\_ip\_on\_launch\_subnet\_public: Whether to map public IP on launch for public subnets. Defaults to true.<br>- map\_public\_ip\_on\_launch\_subnet\_private: Whether to map public IP on launch for private subnets. Defaults to false.<br>- availability\_zones\_limit: The number of availability zones to use. Defaults to 3. | <pre>object({<br>    map_public_ip_on_launch_subnet_public  = optional(bool, true)<br>    map_public_ip_on_launch_subnet_private = optional(bool, false)<br>    availability_zones_limit               = optional(number, 3)<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration object to set common VPC options. Options currently supported:<br>- enable\_dns\_hostnames: Whether to enable DNS hostnames in the VPC. Defaults to true.<br>- enable\_dns\_support: Whether to enable DNS support in the VPC. Defaults to true.<br>- instance\_tenancy: The allowed tenancy of instances launched into the VPC. Defaults to 'default'.<br>- cidr\_block: The CIDR block for the VPC. | <pre>object({<br>    enable_dns_hostnames = optional(bool, true)<br>    enable_dns_support   = optional(bool, true)<br>    instance_tenancy     = optional(string, "default")<br>    cidr_block           = optional(string, "10.0.0.0/20")<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_route_table_private"></a> [route\_table\_private](#output\_route\_table\_private) | Private route table objects. |
| <a name="output_route_table_private_ids"></a> [route\_table\_private\_ids](#output\_route\_table\_private\_ids) | The IDs of the private route tables. |
| <a name="output_route_table_public"></a> [route\_table\_public](#output\_route\_table\_public) | Public route table objects. |
| <a name="output_route_table_public_ids"></a> [route\_table\_public\_ids](#output\_route\_table\_public\_ids) | The IDs of the public route tables. |
| <a name="output_subnet_private"></a> [subnet\_private](#output\_subnet\_private) | Private subnet objects. |
| <a name="output_subnet_private_availability_zones"></a> [subnet\_private\_availability\_zones](#output\_subnet\_private\_availability\_zones) | The availability zones of the private subnets. |
| <a name="output_subnet_private_cidr_blocks"></a> [subnet\_private\_cidr\_blocks](#output\_subnet\_private\_cidr\_blocks) | The CIDR blocks of the private subnets. |
| <a name="output_subnet_private_ids"></a> [subnet\_private\_ids](#output\_subnet\_private\_ids) | The IDs of the private subnets. |
| <a name="output_subnet_private_map_public_ip_on_launch"></a> [subnet\_private\_map\_public\_ip\_on\_launch](#output\_subnet\_private\_map\_public\_ip\_on\_launch) | Whether instances launched in these subnets get public IP addresses. |
| <a name="output_subnet_public"></a> [subnet\_public](#output\_subnet\_public) | Public subnet objects. |
| <a name="output_subnet_public_availability_zones"></a> [subnet\_public\_availability\_zones](#output\_subnet\_public\_availability\_zones) | The availability zones of the public subnets. |
| <a name="output_subnet_public_cidr_blocks"></a> [subnet\_public\_cidr\_blocks](#output\_subnet\_public\_cidr\_blocks) | The CIDR blocks of the public subnets. |
| <a name="output_subnet_public_ids"></a> [subnet\_public\_ids](#output\_subnet\_public\_ids) | The IDs of the public subnets. |
| <a name="output_subnet_public_map_public_ip_on_launch"></a> [subnet\_public\_map\_public\_ip\_on\_launch](#output\_subnet\_public\_map\_public\_ip\_on\_launch) | Whether instances launched in these subnets get public IP addresses. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | VPC object. |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC. |
| <a name="output_vpc_default_network_acl_id"></a> [vpc\_default\_network\_acl\_id](#output\_vpc\_default\_network\_acl\_id) | The ID of the network ACL created by default on VPC creation. |
| <a name="output_vpc_default_route_table_id"></a> [vpc\_default\_route\_table\_id](#output\_vpc\_default\_route\_table\_id) | The ID of the route table created by default on VPC creation. |
| <a name="output_vpc_default_security_group_id"></a> [vpc\_default\_security\_group\_id](#output\_vpc\_default\_security\_group\_id) | The ID of the security group created by default on VPC creation. |
| <a name="output_vpc_dhcp_options_id"></a> [vpc\_dhcp\_options\_id](#output\_vpc\_dhcp\_options\_id) | The ID of the set of DHCP options you've associated with the VPC. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC. |
| <a name="output_vpc_instance_tenancy"></a> [vpc\_instance\_tenancy](#output\_vpc\_instance\_tenancy) | A tenancy option for instances launched into the VPC. |
<!-- END_TF_DOCS -->
