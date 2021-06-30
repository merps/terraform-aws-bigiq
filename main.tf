#
# Ensure Secret exists
#
data "aws_secretsmanager_secret" "password" {
  name = var.aws_secretmanager_secret_id
}
#
# Find BIG-IQ AMI
#
data "aws_ami" "f5_ami" {
  most_recent = true
  owners      = ["679593333241"]
  filter {
    name   = "name"
    values = [var.f5_ami_search_name]
  }
}
# cache IAM Profile
data "aws_iam_instance_profile" "bigiq" {
  name = aws_iam_instance_profile.bigiq_profile.name
}
#
locals {
  hostname = "${var.hostname}.${var.dns_search_domains[0]}"
}
#
# AWS Local VPC data caching
#
data "aws_vpc" "selected" {
  id = var.vpc_id
}
#
# BIG-IQ CM Interfaces
#
resource "aws_network_interface" "cm_mgmt" {
  count           = var.cm_instance_count
  subnet_id       = var.vpc_mgmt_subnet_ids[count.index]
  security_groups = var.mgmt_subnet_security_group_ids
}

resource "aws_network_interface" "cm_private" {
  count           = var.cm_instance_count
  subnet_id       = var.vpc_private_subnet_ids[count.index]
  security_groups = var.private_subnet_security_group_ids
}

#
# BIG-IQ DCD Interfaces
#
resource "aws_network_interface" "dcd_mgmt" {
  count           = var.dcd_instance_count
  subnet_id       = var.vpc_mgmt_subnet_ids[count.index]
  security_groups = var.mgmt_subnet_security_group_ids
}

resource "aws_network_interface" "dcd_private" {
  count           = var.dcd_instance_count
  subnet_id       = var.vpc_private_subnet_ids[count.index]
  security_groups = var.private_subnet_security_group_ids
}
#
# Create a security group for BIG-IQ
#
resource "aws_security_group" "allow_https" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "dcd_node" {
  name        = "dcd_node"
  description = "Replication across Data Collection Device (DCD)"
  vpc_id      = var.vpc_id

  ingress {
    description = "DCD node-to-node"
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "dcd_node"
  }
}

resource "aws_security_group" "dcd_node" {
  name        = "dcd_node"
  description = "Replication across Data Collection Device (DCD)"
  vpc_id      = var.vpc_id

  ingress {
    description = "DCD node-to-node"
    from_port   = 9300
    to_port     = 9300
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "dcd_node"
  }
}

resource "aws_security_group" "big-iq_postgres" {
  name        = "big-iq_postgres"
  description = "postgres daemon IPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "postgres daemon IPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "big-iq_postgres"
  }
}

resource "aws_security_group" "big-iq_corosync" {
  name        = "big-iq_corosync"
  description = "postgres daemon IPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "corosync daemon IPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "udp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "big-iq_corosync"
  }
}
resource "aws_security_group" "big-iq_pacemaker" {
  name        = "big-iq_pacemaker"
  description = "postgres daemon IPC"
  vpc_id      = var.vpc_id

  ingress {
    description = "pacemaker daemon IPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "udp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "big-iq_pacemaker"
  }
}
#
# BIG-IQ EIP Management
#
resource "aws_eip" "cm_mgmt" {
  count             = var.mgmt_eip ? var.cm_instance_count : 0
  network_interface = aws_network_interface.cm_mgmt[count.index].id
  vpc               = true
}

resource "aws_eip" "dcd_mgmt" {
  count             = var.mgmt_eip ? var.dcd_instance_count : 0
  network_interface = aws_network_interface.dcd_mgmt[count.index].id
  vpc               = true
}

#
# Deploy BIG-IQ DCD
#
resource "aws_instance" "f5_bigiq_dcd" {
  # determine the number of BIG-IPs to deploy
  count         = var.dcd_instance_count
  instance_type = var.ec2_instance_type
  ami           = data.aws_ami.f5_ami.id
  #iam_instance_profile = local.big_iq_iam

  key_name = var.ec2_key_name

  root_block_device {
    delete_on_termination = true
    volume_size           = 500
    volume_type           = "gp3"
  }

  # set the mgmt interface
  dynamic "network_interface" {
    for_each = toset([aws_network_interface.dcd_mgmt[count.index].id])

    content {
      network_interface_id = network_interface.value
      device_index         = 0
    }
  }

  # set the private interface only if an interface is defined
  dynamic "network_interface" {
    # for_each = length(aws_network_interface.private) > count.index ? toset([aws_network_interface.private[count.index].id]) : toset([])
    for_each = length(aws_network_interface.dcd_private) > count.index ? toset([aws_network_interface.dcd_private[count.index].id]) : toset([])

    content {
      network_interface_id = network_interface.value
      device_index         = 1
    }
  }

  # build user_data file from template
  user_data = templatefile("${path.module}/setup-cm-background.sh.tmpl",
    {
      admin_password = var.admin_password
      license_key    = var.dcd_license_keys[count.index]
      onboard_log    = var.onboard_log
    }
  )
  depends_on = [aws_eip.dcd_mgmt]

  tags = {
    Name = format("%s-dcd-%d", var.prefix, count.index)
  }
}

#
# Deploy BIG-IQ CM
#
resource "aws_instance" "f5_bigiq_cm" {
  # determine the number of BIG-IPs to deploy
  count                = var.cm_instance_count
  instance_type        = var.ec2_instance_type
  ami                  = data.aws_ami.f5_ami.id
  iam_instance_profile = data.aws_iam_instance_profile.bigiq.name

  key_name = var.ec2_key_name

  root_block_device {
    delete_on_termination = true
  }

  # set the mgmt interface
  dynamic "network_interface" {
    for_each = toset([aws_network_interface.cm_mgmt[count.index].id])

    content {
      network_interface_id = network_interface.value
      device_index         = 0
    }
  }

  # set the private interface only if an interface is defined
  dynamic "network_interface" {
    # for_each = length(aws_network_interface.private) > count.index ? toset([aws_network_interface.private[count.index].id]) : toset([])
    for_each = length(aws_network_interface.cm_private) > count.index ? toset([aws_network_interface.cm_private[count.index].id]) : toset([])

    content {
      network_interface_id = network_interface.value
      device_index         = 1
    }
  }

  # build user_data file from template
  user_data = templatefile("${path.module}/onboard.sh.tmpl",
    {
      admin_name     = var.admin_name
      admin_password = var.admin_password
      onboard_log    = var.onboard_log
      licensekey     = var.cm_license_keys[count.index]
      masterkey      = var.masterkey
      personality    = "big_iq"
      timezone       = var.timezone
      ## todo need to update template to reflect passing of lists
      ntp_servers        = var.ntp_servers[0]
      dns_servers        = var.dns_servers[0]
      dns_search_domains = var.dns_search_domains[count.index]
      hostname           = local.hostname
      management_ip      = aws_network_interface.cm_mgmt[count.index].private_ip
      discovery_ip       = aws_network_interface.cm_mgmt[count.index].private_ip
    }
  )
  depends_on = [aws_eip.cm_mgmt]

  tags = {
    Name = format("%s-cm-%d", var.prefix, count.index)
  }
}

resource "null_resource" "onboard_local" {
  provisioner "file" {
    content = templatefile("${path.module}/onboard.sh.tmpl",
      {
        admin_name     = var.admin_name
        admin_password = var.admin_password
        onboard_log    = var.onboard_log
        licensekey     = var.cm_license_keys[0]
        masterkey      = var.masterkey
        personality    = "big_iq"
        timezone       = var.timezone
        ## todo need to update template to reflect passing of lists
        ntp_servers        = var.ntp_servers[0]
        dns_servers        = var.dns_servers[0]
        dns_search_domains = var.dns_search_domains[0]
        hostname           = local.hostname
        management_ip      = aws_network_interface.cm_mgmt[0].private_ip
        discovery_ip       = aws_network_interface.cm_mgmt[0].private_ip
      }
    )
    destination = "/config/onboard.sh-${var.cm_instance_count}"

    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("${var.ec2_key_name}.pem")
      host        = aws_eip.cm_mgmt[0].public_ip
    }
  }
}
/*
#
# Hack for remote exec of provisioning
#
resource "null_resource" "cm_dcd_activate" {
  depends_on = [aws_instance.f5_bigiq_cm]
  count      = var.cm_instance_count
  provisioner "file" {
    content = templatefile(
      "${path.module}/activate_dcd.sh.tmpl",
      {
        admin_password = var.admin_password
        license_key    = var.cm_license_keys[count.index]
        master_key     = var.masterkey
        personality    = "big_iq"
        timezone       = var.timezone
        ntp_servers    = var.ntp_servers[count.index]
        dns_servers    = var.dns_servers[count.index]
        hostname       = local.hostname
        management_ip  = aws_network_interface.cm_mgmt[count.index].private_ip
        discovery_ip   = aws_network_interface.cm_mgmt[count.index].private_ip
        dcd_ip      = aws_network_interface.dcd_mgmt[count.index].private_ip
        onboard_log = var.onboard_log
      }
    )
    destination = "/config/cloud/activate-dcd.sh"

    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("${var.ec2_key_name}.pem")
      host        = aws_eip.cm_mgmt[count.index].public_ip
    }
  }
  provisioner "file" {
    source = "${path.module}/mpcd.sh.tmpl"
    destination = "/config/cloud/mcpd.sh"

    connection {
      type        = "ssh"
      user        = "admin"
      private_key = file("${var.ec2_key_name}.pem")
      host        = aws_eip.cm_mgmt[count.index].public_ip
    }
  }
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [null_resource.cm_dcd_activate]

  create_duration = "120s"
}

resource "null_resource" "mcpd_wait" {
  depends_on = [time_sleep.wait_120_seconds]
}

resource "null_resource" "mcpd" {
  depends_on = [null_resource.mcpd_wait]
  count      = var.cm_instance_count
  provisioner "remote-exec" {
    inline = [
      "/bin/bash /config/cloud/mcpd.sh",
    ]

    connection {
      type = "ssh"
      user = "admin"
      private_key = file("${var.ec2_key_name}.pem")
      host = aws_eip.cm_mgmt[count.index].public_ip
    }
  }
}

resource "null_resource" "cm_tst" {
# "remote-exec" TF provisioner requires scp access to /tmp
# added to whitelist - https://support.f5.com/csp/article/K30829026
# TODO Find who to ask about cloud-init?
  depends_on = [null_resource.mcpd]
  count      = var.cm_instance_count
  provisioner "remote-exec" {
    inline = [
      "/usr/bin/env python /config/cloud/wait-for-service.py",
      "chmod +x /config/cloud/activate-dcd.sh",
      "nohup /config/cloud/activate-dcd.sh >> /var/log/activated.log",
    ]

    connection {
      type = "ssh"
      user = "admin"
      private_key = file("${var.ec2_key_name}.pem")
      host = aws_eip.cm_mgmt[count.index].public_ip
    }
  }
}
*/