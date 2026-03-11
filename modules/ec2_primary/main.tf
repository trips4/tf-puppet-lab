resource "aws_key_pair" "sshkey" {
  key_name   = "id_puppet_primary"
  public_key = var.pub_key
}

resource "aws_instance" "ec2_pe_primary" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = aws_key_pair.sshkey.key_name
  tags = {
    created_by = "dennis.triplo@perforce.com"
    lifetime   = "1w"
    Name       = var.hostname_short
  }
  root_block_device {
    volume_size = 16
    volume_type = "gp3"
  }
  user_data = local.user_data
}

locals {
  fqdn = var.hostname != "" ? var.hostname : "${var.hostname_short}.${var.domain_suffix}"

  pe_conf = templatefile("${path.module}/templates/pe_conf.tftpl", {
    hostname               = local.fqdn
    console_admin_password = var.console_password
    fqdn                   = local.fqdn
  })

  user_data = templatefile("${path.module}/templates/user_data.tftpl", {
    pe_conf_b64 = base64encode(local.pe_conf)
    hostname    = var.hostname_short
    fqdn        = local.fqdn
  })
}
