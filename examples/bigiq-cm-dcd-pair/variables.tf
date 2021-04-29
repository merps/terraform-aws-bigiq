variable "ec2_key_name" {
  description = "AWS EC2 Key name for SSH access"
  type        = string
}

variable "prefix" {
  description = "Prefix for resources created by this module"
  type        = string
}

variable "region" {
  default = "ap-southeast-2"
}


variable "azs" {
  default = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "allowed_mgmt_cidr" {
  default = "0.0.0.0/0"
}

variable "dcd_license_keys" {
  type = list(string)
}

variable "cm_license_keys" {
  type = list(string)
}
variable "hostname" {}
variable "search_domain" {}