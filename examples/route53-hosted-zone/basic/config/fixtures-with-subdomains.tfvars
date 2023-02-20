aws_region = "us-east-1"
is_enabled = true

hosted_zone_config = [
  {
    name = "www.mydomain.com"
  }
]

hosted_zone_subdomains = [
  {
    name      = "www.mydomain.com"
    subdomain = "something.subdomain.com"
    name_servers = [
      "ns-123.awsdns-12.com",
      "ns-123.awsdns-12.net",
      "ns-123.awsdns-12.org",
    "ns-123.awsdns-12.co.uk"]
  }
]
