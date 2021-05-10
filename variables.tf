variable "prefix" {
  description = "Prefix for resources created by this module"
  type        = string
  default     = "terraform-aws-bigiq-demo"
}

variable "f5_ami_search_name" {
  description = "BIG-IP AMI name to search for"
  type        = string
  default     = "F5 Hourly BIG-IQ-8*"
}

variable "dcd_instance_count" {
  description = "Number of BIG-IPs to deploy"
  type        = number
  default     = 1
}

variable "cm_instance_count" {
  description = "Number of BIG-IPs to deploy"
  type        = number
  default     = 1
}

variable "ec2_instance_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "m4.xlarge"
}

variable "ec2_key_name" {
  description = "AWS EC2 Key name for SSH access"
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "AWS VPC Subnet id for the public subnet"
  type        = list(any)
}

variable "vpc_mgmt_subnet_ids" {
  description = "AWS VPC Subnet id for the management subnet"
  type        = list(any)
}

variable "mgmt_eip" {
  description = "Enable an Elastic IP address on the management interface"
  type        = bool
  default     = true
}

variable "mgmt_subnet_security_group_ids" {
  description = "AWS Security Group ID for BIG-IP management interface"
  type        = list(any)
}

variable "private_subnet_security_group_ids" {
  description = "AWS Security Group ID for BIG-IP private interface"
  type        = list(any)
}

variable "aws_secretmanager_secret_id" {
  description = "AWS Secret Manager Secret ID that stores the BIG-IP password"
  type        = string
}

variable "onboard_log" {
  description = "Directory on the BIG-IP to store the cloud-init logs"
  type        = string
  default     = "/var/log/startup-script.log"
}

variable "admin_name" {
  description = "Admin user on the BIG-IQ"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Admin user on the BIG-IQ"
  type        = string
  default     = ""
}

variable "cm_license_keys" {
  description = "BIG-IQ CM License Keys"
  type        = list(string)
}

variable "dcd_license_keys" {
  description = "BIG-IQ DCD License Keys"
  type        = list(string)
}

variable "ntp_servers" {
  description = "BIG-IQ NTP Servers"
  type        = list(string)
  default     = ["169.254.169.123"]
}

variable "dns_servers" {
  description = "BIG-IQ DNS Servers"
  type        = list(string)
  default     = ["169.254.169.253"]
}

variable "dns_search_domains" {
  description = "BIG-IQ DNS Search Domains"
  type        = list(string)
  default     = ["test.local"]
}

variable "personality" {
  description = "BIG-IQ Node Type (logging_node/big_iq)"
  type        = string
  default     = ""
}

## TODO address this with iterations
variable "hostname" {
  description = "BIG-IQ Hostname"
  type        = string
  default     = "buggered-thing-already"
}
# admin
variable "adminName" {
  description = "admin account name"
  default     = "admin"
}
variable "masterkey" {
  description = "bigiq master key"
  default     = "ThisIsIt%1234"
}
variable "location" { default = "apsoutheast2" }

variable "timezone" {
  description = "BIG-IQ CM/DCD Deployed Time Zone"
  default     = "Australia/Sydney"
}