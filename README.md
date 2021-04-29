## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_time"></a> [time](#provider\_time) | n/a |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adminName"></a> [adminName](#input\_adminName) | admin account name | `string` | `"admin"` | no |
| <a name="input_admin_name"></a> [admin\_name](#input\_admin\_name) | Admin user on the BIG-IQ | `string` | `"admin"` | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin user on the BIG-IQ | `string` | n/a | yes |
| <a name="input_aws_secretmanager_secret_id"></a> [aws\_secretmanager\_secret\_id](#input\_aws\_secretmanager\_secret\_id) | AWS Secret Manager Secret ID that stores the BIG-IP password | `string` | n/a | yes |
| <a name="input_cm_instance_count"></a> [cm\_instance\_count](#input\_cm\_instance\_count) | Number of BIG-IPs to deploy | `number` | `1` | no |
| <a name="input_cm_license_keys"></a> [cm\_license\_keys](#input\_cm\_license\_keys) | BIG-IQ CM License Keys | `list(string)` | n/a | yes |
| <a name="input_dcd_instance_count"></a> [dcd\_instance\_count](#input\_dcd\_instance\_count) | Number of BIG-IPs to deploy | `number` | `1` | no |
| <a name="input_dcd_license_keys"></a> [dcd\_license\_keys](#input\_dcd\_license\_keys) | BIG-IQ DCD License Keys | `list(string)` | n/a | yes |
| <a name="input_dns_search_domains"></a> [dns\_search\_domains](#input\_dns\_search\_domains) | BIG-IQ DNS Search Domains | `list(string)` | <pre>[<br>  "test.local"<br>]</pre> | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | BIG-IQ DNS Servers | `list(string)` | <pre>[<br>  "169.254.169.253"<br>]</pre> | no |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | AWS EC2 instance type | `string` | `"m4.xlarge"` | no |
| <a name="input_ec2_key_name"></a> [ec2\_key\_name](#input\_ec2\_key\_name) | AWS EC2 Key name for SSH access | `string` | n/a | yes |
| <a name="input_f5_ami_search_name"></a> [f5\_ami\_search\_name](#input\_f5\_ami\_search\_name) | BIG-IP AMI name to search for | `string` | `"F5 Hourly BIG-IQ-8*"` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | BIG-IQ Hostname | `string` | `"buggered-thing-already"` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `string` | `"apsoutheast2"` | no |
| <a name="input_masterkey"></a> [masterkey](#input\_masterkey) | bigiq master key | `string` | `"ThisIsIt%1234"` | no |
| <a name="input_mgmt_eip"></a> [mgmt\_eip](#input\_mgmt\_eip) | Enable an Elastic IP address on the management interface | `bool` | `true` | no |
| <a name="input_mgmt_subnet_security_group_ids"></a> [mgmt\_subnet\_security\_group\_ids](#input\_mgmt\_subnet\_security\_group\_ids) | AWS Security Group ID for BIG-IP management interface | `list(any)` | n/a | yes |
| <a name="input_ntp_servers"></a> [ntp\_servers](#input\_ntp\_servers) | BIG-IQ NTP Servers | `list(string)` | <pre>[<br>  "169.254.169.123"<br>]</pre> | no |
| <a name="input_onboard_log"></a> [onboard\_log](#input\_onboard\_log) | Directory on the BIG-IP to store the cloud-init logs | `string` | `"/var/log/startup-script.log"` | no |
| <a name="input_personality"></a> [personality](#input\_personality) | BIG-IQ Node Type (logging\_node/big\_iq) | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix for resources created by this module | `string` | `"terraform-aws-bigiq-demo"` | no |
| <a name="input_private_subnet_security_group_ids"></a> [private\_subnet\_security\_group\_ids](#input\_private\_subnet\_security\_group\_ids) | AWS Security Group ID for BIG-IP private interface | `list(any)` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | BIG-IQ CM/DCD Deployed Time Zone | `string` | `"Australia/Sydney"` | no |
| <a name="input_vpc_mgmt_subnet_ids"></a> [vpc\_mgmt\_subnet\_ids](#input\_vpc\_mgmt\_subnet\_ids) | AWS VPC Subnet id for the management subnet | `list(any)` | n/a | yes |
| <a name="input_vpc_private_subnet_ids"></a> [vpc\_private\_subnet\_ids](#input\_vpc\_private\_subnet\_ids) | AWS VPC Subnet id for the public subnet | `list(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cm_discovery_ips"></a> [cm\_discovery\_ips](#output\_cm\_discovery\_ips) | List of BIG-IQ DCD Private IP's |
| <a name="output_cm_mgmt_port"></a> [cm\_mgmt\_port](#output\_cm\_mgmt\_port) | HTTPS Port used for the BIG-IQ management interface |
| <a name="output_cm_mgmt_private_ip"></a> [cm\_mgmt\_private\_ip](#output\_cm\_mgmt\_private\_ip) | List of BIG-IQ Private IP's |
| <a name="output_cm_mgmt_public_ips"></a> [cm\_mgmt\_public\_ips](#output\_cm\_mgmt\_public\_ips) | List of BIG-IP public IP addresses for the management interfaces |
| <a name="output_cm_public_nic_ids"></a> [cm\_public\_nic\_ids](#output\_cm\_public\_nic\_ids) | List of BIG-IQ public network interface ids |
| <a name="output_dcd_discovery_ips"></a> [dcd\_discovery\_ips](#output\_dcd\_discovery\_ips) | List of BIG-IQ DCD Private IP's |
| <a name="output_dcd_mgmt_port"></a> [dcd\_mgmt\_port](#output\_dcd\_mgmt\_port) | HTTPS Port used for the BIG-IQ management interface |
| <a name="output_dcd_mgmt_private_ips"></a> [dcd\_mgmt\_private\_ips](#output\_dcd\_mgmt\_private\_ips) | List of BIG-IQ CM Private IP's |
| <a name="output_dcd_mgmt_public_ips"></a> [dcd\_mgmt\_public\_ips](#output\_dcd\_mgmt\_public\_ips) | List of BIG-IP public IP addresses for the management interfaces |
