module "main_module" {
  source     = "../../../modules/vpc"
  is_enabled = var.is_enabled
  aws_region = var.aws_region

  // VPC configuration
  vpc_config = {
  }
  subnet_config = {
  }
}
