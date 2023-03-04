variable "is_enabled" {
  type        = bool
  description = <<EOF
  Whether this module will be created or not. It is useful, for stack-composite
modules that conditionally includes resources provided by this module..
EOF
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy the resources"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to add to all resources."
  default     = {}
}

/*
-------------------------------------
Custom input variables
-------------------------------------
*/
variable "attachment_config" {
  type = list(object({
    name              = string
    backend_id        = string
    target_group_arn  = string
    availability_zone = optional(string)
    port              = optional(number)
  }))
  description = <<EOF
  A list of objects that contains the backend_id and target_group_arn to be attached. The current attributes that are supported:
  - name (string): The name of the attachment.
  - backend_id (string): The ID of the backend to attach to the target group.
  - target_group_arn (string): The Amazon Resource Name (ARN) of the target group.
  - availability_zone (string): The Availability Zone where the IP address is located.
  - port (number): The port on which the target is listening.
  EOF
  default     = null
}
