aws_region = "us-east-1"
is_enabled = true

action_forward_config = [
  {
    name = "test"
    rules = [
      {
        target_group = [
          {
            arn    = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-targets/73e2d6bc24d8a067"
            weight = 1
          },
          {
            arn    = "arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-other-targets/73e2d6bc24d8a067"
            weight = 1
          }
        ]
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
  },
  {
    name = "test"
    conditions = [
      {
        http_request_method_config = ["GET"]
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        http_header_config = {
          header = "x-header"
          values = ["value"]
        }
      }
    ]
  },
  {
    name = "test"
    conditions = [
      {
        query_string_config = {
          key   = "key"
          value = "value"
        }
      }
    ]
  }
]
