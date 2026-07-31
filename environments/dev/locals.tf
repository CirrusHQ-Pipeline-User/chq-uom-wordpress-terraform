locals {

  common_tags = {
    Application = var.application_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  name_prefix = "${var.application_name}-${var.environment}"
}