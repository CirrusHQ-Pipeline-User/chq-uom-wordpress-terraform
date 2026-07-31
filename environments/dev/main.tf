#
# Network
#


module "network" {
  source = "../../modules/network"

  aws_region       = var.region
  application_name = var.application_name
  environment      = var.environment
  cidr_base        = var.cidr_base
  tags             = local.common_tags
}


#
# Security
#

# module "security" {
#   source = "../../modules/security"
# }

#
# Database
#

# module "database" {
#   source = "../../modules/database"
# }

#
# Application
#

# module "alb" {
# }

# module "compute" {
# }

#
# Monitoring
#

# module "monitoring" {
# }

#
# WordPress
#

# module "wordpress" {
# }