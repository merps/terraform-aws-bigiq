##
# CM
#
output "cm_mgmt_public_ips" {
  description = "List of BIG-IP public IP addresses for the management interfaces"
  value       = aws_eip.cm_mgmt[*].public_ip
}

output "cm_mgmt_port" {
  description = "HTTPS Port used for the BIG-IQ management interface"
  value       = "443"
}

output "cm_public_nic_ids" {
  description = "List of BIG-IQ public network interface ids"
  value       = aws_network_interface.cm_mgmt[*].id
}

output "cm_mgmt_private_ip" {
  description = "List of BIG-IQ Private IP's"
  value = aws_network_interface.cm_mgmt[*].private_ip
}

##
# DCD
#
output "cm_discovery_ips" {
  description = "List of BIG-IQ DCD Private IP's"
  value = aws_network_interface.dcd_private[*].private_ip
}

output "dcd_mgmt_public_ips" {
  description = "List of BIG-IP public IP addresses for the management interfaces"
  value       = aws_eip.dcd_mgmt[*].public_ip
}
output "dcd_mgmt_private_ips" {
  description = "List of BIG-IQ CM Private IP's"
  value = aws_network_interface.dcd_mgmt[*].private_ip
}

output "dcd_mgmt_port" {
  description = "HTTPS Port used for the BIG-IQ management interface"
  value       = "443"
}

output "dcd_discovery_ips" {
  description = "List of BIG-IQ DCD Private IP's"
  value = aws_network_interface.dcd_private[*].private_ip
}