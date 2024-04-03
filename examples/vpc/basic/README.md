<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main_module"></a> [main\_module](#module\_main\_module) | ../../../modules/vpc | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

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
