aws_region = "us-east-1"
is_enabled = true

alb_config = [
  {
    name           = "test-alb"
    subnets_public = ["subnet-0846305bebd4a81f7", "subnet-0779cabff259d1412"]
  }
]
