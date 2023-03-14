aws_region = "us-east-1"
is_enabled = true

action_redirect_https = [
  {
    name         = "test"
    listener_arn = "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/my-load-balancer/50dc6c495c0c9188/f2f7dc8efc522ab2"
    http_header_condition = {
      header = "X-Forwarded-Proto"
      values = ["http"]
    }
  }
]
