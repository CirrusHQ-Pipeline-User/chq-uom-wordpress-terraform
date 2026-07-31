variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-2"
}

variable "application_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "hosted_zone" {
  type = string
}

variable "cidr_base" {
  type = string
}