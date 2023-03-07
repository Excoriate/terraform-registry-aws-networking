locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
  */
  is_vpc_data_enabled    = !var.is_enabled ? false : var.vpc_data == null ? false : true
  is_dns_data_enabled    = !var.is_enabled ? false : var.dns_data == null ? false : true
  fetch_dns_zone_enabled = !local.is_dns_data_enabled ? false : var.dns_data.fetch_zone
  fetch_dns_acm_enabled  = !local.is_dns_data_enabled ? false : var.dns_data.fetch_acm_certificate
  retrieve_public_by_az  = !local.is_vpc_data_enabled ? false : var.vpc_data.retrieve_subnets_public && var.vpc_data.filter_by_az
  retrieve_private_by_az = !local.is_vpc_data_enabled ? false : var.vpc_data.retrieve_subnets_private && var.vpc_data.filter_by_az

  /*
   * VPC data
  */
  vpc_data = !local.is_vpc_data_enabled ? [] : [
    {
      vpc_name                  = lower(trimspace(var.vpc_data.name))
      subnet_public_identifier  = format("*%s*", lower(trimspace(var.vpc_data.subnet_public_identifier)))
      subnet_private_identifier = format("*%s*", lower(trimspace(var.vpc_data.subnet_private_identifier)))
      // Options.
      retrieve_all          = var.vpc_data.retrieve_subnets
      retrieve_only_public  = var.vpc_data.retrieve_subnets_public
      retrieve_only_private = var.vpc_data.retrieve_subnets_private
      filter_by_az          = var.vpc_data.filter_by_az
    }
  ]

  vpc_data_fetch = !local.is_vpc_data_enabled ? {} : {
    for data in local.vpc_data : data.vpc_name => data
  }

  subnet_private_fetch = !local.is_vpc_data_enabled ? {} : {
    for data in local.vpc_data : data.vpc_name => {
      vpc_name   = data.vpc_name
      identifier = data.subnet_private_identifier
    } if data.retrieve_only_private
  }

  subnet_public_fetch = !local.is_vpc_data_enabled ? {} : {
    for data in local.vpc_data : data.vpc_name => {
      vpc_name   = data.vpc_name
      identifier = data.subnet_public_identifier
    } if data.retrieve_only_public
  }

  subnet_public_fetch_by_az = !local.is_vpc_data_enabled ? {} : {
    for data in local.vpc_data : data.vpc_name => {
      vpc_name   = data.vpc_name
      identifier = data.subnet_public_identifier
    } if data.retrieve_only_public && data.filter_by_az
  }

  subnet_private_fetch_by_az = !local.is_vpc_data_enabled ? {} : {
    for data in local.vpc_data : data.vpc_name => {
      vpc_name   = data.vpc_name
      identifier = data.subnet_private_identifier
    } if data.retrieve_only_private && data.filter_by_az
  }


  subnet_all_fetch = !local.is_vpc_data_enabled ? {} : {
    for data in local.vpc_data : data.vpc_name => {
      vpc_name = data.vpc_name
    } if data.retrieve_all
  }

  /*
   * DNS data
  */
  dns_data = !local.is_dns_data_enabled ? [] : [
    {
      domain_name   = lower(trimspace(var.dns_data.domain))
      dns_zone_name = lower(trimspace(var.dns_data.domain)) // normally it corresponds to the domain name.
      // Options.
      fetch_zone            = var.dns_data.fetch_zone
      fetch_acm_certificate = var.dns_data.fetch_acm_certificate
    }
  ]

  dns_data_fetch = !local.is_dns_data_enabled ? {} : {
    for data in local.dns_data : data.dns_zone_name => data
  }

  dns_zone_fetch = !local.is_dns_data_enabled ? {} : {
    for data in local.dns_data : data["domain_name"] => {
      domain_name   = data.domain_name
      dns_zone_name = data.dns_zone_name
    } if data.fetch_zone
  }

  dns_acm_fetch = !local.is_dns_data_enabled ? {} : {
    for data in local.dns_data : data["domain_name"] => {
      domain_name = data.domain_name
    } if data.fetch_acm_certificate
  }
}
