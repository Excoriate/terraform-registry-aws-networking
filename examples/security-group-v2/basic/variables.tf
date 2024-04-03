###################################
# Input Variables 🛠️
# ----------------------------------------------------
#
# These variables allow users to customize the module according to their needs.
# Each variable is documented with its description, type, and default value if applicable.
#
###################################

variable "is_enabled" {
  type        = bool
  description = <<-DESC
  Whether this module will be created or not. Useful for stack-composite
  modules that conditionally include resources provided by this module.
  DESC
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

variable "security_group_config" {
  type = object({
    name        = string
    description = optional(string, "Managed by Terraform")
    vpc_id      = string
    ingress     = optional(list(object({
      description      = optional(string, "Ingress Rule")
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string), [])
      ipv6_cidr_blocks = optional(list(string), [])
      prefix_list_ids  = optional(list(string), [])
      security_groups  = optional(list(string), [])
      self             = optional(bool, false)
    })), [])
    egress = optional(list(object({
      description      = optional(string, "Egress Rule")
      from_port        = number
      to_port          = number
      protocol         = string
      cidr_blocks      = optional(list(string), [])
      ipv6_cidr_blocks = optional(list(string), [])
      prefix_list_ids  = optional(list(string), [])
      security_groups  = optional(list(string), [])
      self             = optional(bool, false)
    })), [])
  })
  description = <<-DESC
  An object  representing the configuration for a security group, facilitating detailed control over ingress and egress rules.

  - `name`: The name of the security group.
  - `description`: Describes the security group (default: "Managed by Terraform").
  - `vpc_id`: The VPC ID for the security group (See [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html)).

  Each `ingress` and `egress` rule object can have the following attributes:

  - `description`: Rule description (default: "Ingress Rule" or "Egress Rule").
  - `from_port`: Starting port range or ICMP type number.
  - `to_port`: Ending port range or ICMP code number.
  - `protocol`: Protocol type (e.g., "tcp", "udp", "icmp", or "-1" for all).
  - `cidr_blocks`: CIDR blocks allowed (default: empty).
  - `ipv6_cidr_blocks`: IPv6 CIDR blocks allowed (default: empty).
  - `prefix_list_ids`: Prefix list IDs for VPC endpoint access (default: empty).
  - `security_groups`: Security group IDs allowed (default: empty).
  - `self`: Apply the rule to the security group itself (default: false).

  For more details on defining security groups with Terraform, refer to the [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group).
  DESC
  default     = null
}
