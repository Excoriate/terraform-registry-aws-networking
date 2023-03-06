aws_region = "us-east-1"
is_enabled = true

action_redirect_config = [
  {
    name = "test"
    // actual rules to apply
    rules = [
      {
        redirect_config = {
          host        = "www.example.com"
          path        = "/new_path"
          port        = "443"
          protocol    = "HTTPS"
          query       = "query=parameter"
          status_code = "HTTP_301"
        }
      }
    ]
  }
]

conditions_config = [
  {
    name = "test"
    conditions = [
      {
        host_header_config = ["www.example.com"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        path_pattern_config = ["/*"]
      }
    ]
  }
]
