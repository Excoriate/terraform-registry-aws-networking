locals {
  /*
    * Global, and control variables.
  */
  aws_region_to_deploy = var.aws_region

  /*
   * Control flags
  */
  is_vpc_data_enabled    = !var.is_enabled ? false : var.vpc_data == null ? false : true
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
}
