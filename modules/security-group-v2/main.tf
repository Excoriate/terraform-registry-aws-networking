###################################
# Module Resources 🛠️
# ----------------------------------------------------
#
# This section declares the resources that will be created or managed by this Terraform module.
# Each resource is annotated with comments explaining its purpose and any notable configurations.
#
###################################

# Example resource: AWS SQS Queue
# This resource demonstrates how to create a simple SQS queue with a random name.
# The `for_each` is used to conditionally create resources based on the module's enabled state.

resource "aws_security_group" "this" {
  for_each = local.sg_groups_to_create

  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = each.value["vpc_id"]

  tags = var.tags

  dynamic "ingress" {
    for_each = each.value["ingress"]

    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]
      prefix_list_ids  = ingress.value["prefix_list_ids"]
      security_groups  = ingress.value["security_groups"]
      self             = ingress.value["self"]
    }
  }

  dynamic "egress" {
    for_each = each.value["egress"]

    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
      prefix_list_ids  = egress.value["prefix_list_ids"]
      security_groups  = egress.value["security_groups"]
      self             = egress.value["self"]
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "rds_ingress" {
  for_each = local.is_enabled_rds_sg_rule ? { for idx, rule in local.sg_rule_rds_normalised : idx => rule } : {}

  security_group_id        = join("", [for sg in aws_security_group.this : sg.id])
  type                     = each.value["type"]
  from_port                = each.value["from_port"]
  to_port                  = each.value["to_port"]
  protocol                 = each.value["protocol"]
  description              = each.value["description"]
  cidr_blocks              = each.value["cidr_blocks"]
  source_security_group_id = length(each.value["security_groups"]) > 0 ? each.value["security_groups"][0] : null
}

resource "aws_security_group_rule" "rds_egress_default" {
  for_each = local.is_enabled_rds_sg_rule ? { for idx, rule in local.sg_rule_rds_egress_default : idx => rule } : {}

  security_group_id = join("", [for sg in aws_security_group.this : sg.id])
  type              = each.value["type"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  cidr_blocks       = each.value["cidr_blocks"]
  description       = each.value["description"]
}
