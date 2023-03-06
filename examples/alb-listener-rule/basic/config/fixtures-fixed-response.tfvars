aws_region = "us-east-1"
is_enabled = true

action_fixed_response_config = [
  {
    name = "test"
    rules = [
      {
        content_type = "text/plain"
        message_body = "test"
        status_code  = "200"
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
