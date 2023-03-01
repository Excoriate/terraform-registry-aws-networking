<!-- BEGIN_TF_DOCS -->
# ☁️ ACM (Amazon Certificate Manager) certificate
## Description

This module creates an ACM certificate, and optionally, a DNS validation record.
* 🚀 Create an ACM certificate
* 🚀 Create a DNS validation record
For more information on the AWS Application Load Balancer, see the [AWS documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html).

---
## Example
Examples of this module's usage are available in the [examples](./examples) folder.

```hcl
module "main_module" {
  source     = "../../../modules/acm-certificate"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  acm_certificate_config = var.acm_certificate_config
  acm_validation_config  = var.acm_validation_config
}
```


It also supports validations. Ensure that the `domain_name` and the certificate `name` are consistent
```hcl
aws_region = "us-east-1"
is_enabled = true

acm_certificate_config = [
  {
    name                        = "acm-cert-test-2"
    domain_name                 = "4id.network"
    wait_for_certificate_issued = true
    validation_config = {
      name      = "acm-cert-test-2"
      zone_name = "4id.network"
    }
  }
]

acm_validation_config = [
  {
    name        = "acm-cert-test-2"
    zone_name   = "4id.network"
    domain_name = "4id.network"
  }
]
```
---

## Module's documentation
(This documentation is auto-generated using [terraform-docs](https://terraform-docs.io))
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.55.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_zone.lookup_for_zone_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_route53_zone.lookup_for_zone_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.48.0, < 5.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_config"></a> [acm\_certificate\_config](#input\_acm\_certificate\_config) | A list of ACM certificate configurations. Each configuration is an object with the following attributes:<br>  - name: The name of the certificate. It will be used to name the ACM certificate resource.<br>  - domain\_name: The domain name for which the certificate is requested.<br>  - subject\_alternative\_names: A list of additional FQDNs to be included in the Subject Alternative Name extension of the ACM certificate.<br>  - certificate\_transparency\_logging\_preference: The certificate transparency logging preference. Valid values are ENABLED or DISABLED.<br>  - wait\_for\_certificate\_issued: Whether to wait for the certificate to be issued or not. | <pre>list(object({<br>    name                                        = string<br>    domain_name                                 = string<br>    subject_alternative_names                   = optional(list(string), [])<br>    certificate_transparency_logging_preference = optional(string, "ENABLED")<br>    wait_for_certificate_issued                 = optional(bool, false)<br>  }))</pre> | `null` | no |
| <a name="input_acm_validation_config"></a> [acm\_validation\_config](#input\_acm\_validation\_config) | Configuration object that allows a separated validation (DNS or Email) for the ACM certificates.<br>It is useful when you want to use a different Route53 hosted zone for the validation records.<br>Current supported attributes are:<br>- name: The name of the certificate. It will be used to name the ACM certificate resource.<br>- domain\_name: The domain name for which the certificate is requested.<br>- zone\_id: The ID of the Route53 hosted zone to contain the validation record.<br>- zone\_name: The name of the Route53 hosted zone to contain the validation record. It'll take precedence over zone\_id.<br>- is\_private\_zone: Whether the Route53 hosted zone is private or not.<br>- ttl: The TTL of the validation record. | <pre>list(object({<br>    name            = string<br>    domain_name     = string<br>    zone_id         = optional(string, null)<br>    zone_name       = optional(string, null) // it'll take precedence<br>    is_private_zone = optional(bool, false)<br>    ttl             = optional(number, 300)<br>  }))</pre> | `null` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region to deploy the resources | `string` | n/a | yes |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether this module will be created or not. It is useful, for stack-composite<br>modules that conditionally includes resources provided by this module.. | `bool` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the ACM certificate. |
| <a name="output_acm_certificate_domain_name"></a> [acm\_certificate\_domain\_name](#output\_acm\_certificate\_domain\_name) | The domain name for the certificate. |
| <a name="output_acm_certificate_id"></a> [acm\_certificate\_id](#output\_acm\_certificate\_id) | The ID of the ACM certificate. |
| <a name="output_acm_certificate_status"></a> [acm\_certificate\_status](#output\_acm\_certificate\_status) | The status of the certificate. |
| <a name="output_acm_zone_by_zone_id"></a> [acm\_zone\_by\_zone\_id](#output\_acm\_zone\_by\_zone\_id) | The ID of the hosted zone, when the zone\_id lookup option is enabled. |
| <a name="output_acm_zone_by_zone_name"></a> [acm\_zone\_by\_zone\_name](#output\_acm\_zone\_by\_zone\_name) | The name of the hosted zone, when the zone\_name lookup option is enabled. |
| <a name="output_aws_region_for_deploy"></a> [aws\_region\_for\_deploy](#output\_aws\_region\_for\_deploy) | The AWS region where the module is deployed. |
| <a name="output_aws_region_for_deploy_this"></a> [aws\_region\_for\_deploy\_this](#output\_aws\_region\_for\_deploy\_this) | The AWS region where the module is deployed. |
| <a name="output_feature_flags"></a> [feature\_flags](#output\_feature\_flags) | n/a |
| <a name="output_is_enabled"></a> [is\_enabled](#output\_is\_enabled) | Whether the module is enabled or not. |
| <a name="output_tags_set"></a> [tags\_set](#output\_tags\_set) | The tags set for the module. |
<!-- END_TF_DOCS -->