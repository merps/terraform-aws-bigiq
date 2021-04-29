# VPC
output "vpc" {
  value = module.vpc
}

# BIG-IQ Management Public IP Addresses
output "bigiq_iq_mgmt_ips" {
  value = module.bigiq.cm_mgmt_private_ip
}

# BIG-IQ Management Public DNS Address
output "bigiq_iq_mgmt_dns" {
  value = module.bigiq.cm_mgmt_public_ips
}

# BIG-IQ Management Port
output "bigiq_iq_mgmt_port" {
  value = module.bigiq.cm_mgmt_port
}
# BIG-IQ Management Public IP Addresses
output "bigiq_dcd_mgmt_ips" {
  value = module.bigiq.dcd_mgmt_private_ips
}

# BIG-IQ Management Public DNS Address
output "bigiq_dcd_mgmt_dns" {
  value = module.bigiq.dcd_mgmt_public_ips
}

# BIG-IQ Management Port
output "bigiq_dcd_mgmt_port" {
  value = module.bigiq.dcd_mgmt_port
}

# BIG-IQ Password
output "password" {
  value     = random_password.password
  sensitive = true
}

# BIG-IQ Password Secret name
output "aws_secretmanager_secret_name" {
  value = aws_secretsmanager_secret.bigiq.name
}
