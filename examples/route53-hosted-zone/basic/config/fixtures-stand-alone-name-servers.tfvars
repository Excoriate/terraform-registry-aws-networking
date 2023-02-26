aws_region = "us-east-1"
is_enabled = true

hosted_zone_stand_alone = [
  {
    name = "mydomain.com"
  }
]

hosted_zone_stand_alone_name_servers = [
  {
    hosted_zone_name = "mydomain.com"
    record_name      = "dev.mydomain.com"
    name_servers = [
      "ns-1234.awsdns-12.org",
      "ns-1234.awsdns-12.co.uk",
      "ns-1234.awsdns-12.com",
      "ns-1234.awsdns-12.net"
    ]
  }
]
