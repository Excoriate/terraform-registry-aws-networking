aws_region = "us-east-1"
is_enabled = true

hosted_zone_subdomains_parent = {
  name   = "mydomain.com"
  coment = "custom dns zone from testing."
}

hosted_zone_subdomains_childs = [
  {
    domain = "mydomain.com"
    name   = "dev"
  },
  {
    domain = "mydomain.com"
    name   = "qa"
  },
  {
    domain = "mydomain.com"
    name   = "prod"
  },
]
