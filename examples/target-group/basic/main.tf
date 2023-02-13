module "main_module" {
  source     = "../../../modules/target-group"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  target_group_config = [
    {
      name   = "alb-tg-1"
      vpc_id = data.aws_vpc.default_vpc.id
      port   = 8080
    }
  ]
}

data "aws_vpc" "default_vpc" {
  default = true
}
