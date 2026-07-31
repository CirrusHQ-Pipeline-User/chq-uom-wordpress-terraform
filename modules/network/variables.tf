variable "application_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "cidr_base" {
  description = "VPC CIDR block"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}