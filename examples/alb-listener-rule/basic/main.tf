module "main_module" {
  source     = "../../../modules/alb-listener-rule"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  listener_rules_config = [{
    name         = "test"
    listener_arn = aws_alb_listener.alb_listener.arn
    priority     = 1
  }]

  action_redirect_config             = var.action_redirect_config
  action_authenticate_cognito_config = var.action_authenticate_cognito_config
  action_forward_config              = var.action_forward_config
  action_fixed_response_config       = var.action_fixed_response_config
  conditions_config                  = var.conditions_config
}


resource "aws_alb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = []
  subnets            = []
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}

data "aws_vpc" "vpc" {
  default = false

  filter {
    name   = "tag:Name"
    values = ["tsn-sandbox-us-east-1-network-core-cross-vpc-backbone"]
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "alb-tg-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id
}
