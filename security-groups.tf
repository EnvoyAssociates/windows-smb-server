#########################
# WireGuard VPN
#########################

module "wireguard_vpn_sg" {
  source = "cloudposse/security-group/aws"
  version = "2.2.0"
  
  attributes = ["${var.account_type}-${var.env}-${var.name}", "wireguard-sg"]
  security_group_description = "Wireguard Security Group"
  vpc_id  = module.vpc.vpc_id
  allow_all_egress = true

  rules = [
    {
      key         = "allow_all"
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = []
      self        = true
      description = "Inbound from all resources in this SG"
    },
    {
      key         = "wireguard_envoy"
      type        = "ingress"
      from_port   = 51820
      to_port     = 51820
      protocol    = "udp"
      cidr_blocks = ["157.231.92.5/32"]
      self        = null
      description = "Wireguard from Envoy Office"
    },
    {
      key         = "smb_envoy"
      type        = "ingress"
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      cidr_blocks = ["192.168.1.0/24"]
      self        = null
      description = "SMB from Envoy Office"
    },
    {
      key         = "ssh_gr_home"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["82.22.173.10/32"] # this is probably out of date! 
      self        = null
      description = "SSH from GR home"
    }
  ]

  create_before_destroy = true
  preserve_security_group_id = true
}

#########################
# SMB File Server
#########################

module "windows_smb_sg" {
  source = "cloudposse/security-group/aws"
  version = "2.2.0"
  
  attributes = ["${var.account_type}-${var.env}-${var.name}", "fileserver-sg"]
  security_group_description = "SMB File Server Security Group"
  vpc_id  = module.vpc.vpc_id
  allow_all_egress = true

  rules = [
    {
      key         = "allow_all"
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = []
      self        = true
      description = "Inbound from all resources in this SG"
    },
    {
      key         = "smb_vpc"
      type        = "ingress"
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/24"]
      self        = null
      description = "SMB from VPC network"
    },
    {
      key         = "rdp_vpc"
      type        = "ingress"
      from_port   = 3389
      to_port     = 3389
      protocol    = "tcp"
      cidr_blocks = ["10.1.0.0/24"]
      self        = null
      description = "RDP from VPC network"
    }
  ]

  create_before_destroy = true
  preserve_security_group_id = true
}

#########################
# FTPS Server
#########################

module "ftps_server_sg" {
  source = "cloudposse/security-group/aws"
  version = "2.2.0"
  
  attributes = ["${var.account_type}-${var.env}-${var.name}", "ftps-server-sg"]
  security_group_description = "FTPS Server Security Group"
  vpc_id  = module.vpc.vpc_id
  allow_all_egress = true

  rules = [
    {
      key         = "allow_all"
      type        = "ingress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = []
      self        = true
      description = "Inbound from all resources in this SG"
    },
    {
      key         = "ftp_envoy"
      type        = "ingress"
      from_port   = 20
      to_port     = 21
      protocol    = "tcp"
      cidr_blocks = ["157.231.92.5/32"]
      self        = null
      description = "FTP from Envoy network"
    },
    {
      key         = "ftp_bj"
      type        = "ingress"
      from_port   = 20
      to_port     = 21
      protocol    = "tcp"
      cidr_blocks = ["193.200.101.50/32"]
      self        = null
      description = "FTP from BJ network"
    },
    {
      key         = "ftp_bj_dr"
      type        = "ingress"
      from_port   = 20
      to_port     = 21
      protocol    = "tcp"
      cidr_blocks = ["194.50.80.180/32"]
      self        = null
      description = "FTP from BJ DR network"
    },
    {
      key         = "ftp_gez"
      type        = "ingress"
      from_port   = 20
      to_port     = 21
      protocol    = "tcp"
      cidr_blocks = ["82.22.173.9/32"]
      self        = null
      description = "FTP from Gez network"
    },
    {
      key         = "ftps_envoy"
      type        = "ingress"
      from_port   = 990
      to_port     = 990
      protocol    = "tcp"
      cidr_blocks = ["157.231.92.5/32"]
      self        = null
      description = "FTPS from Envoy network"
    },
    {
      key         = "ftps_bj"
      type        = "ingress"
      from_port   = 990
      to_port     = 990
      protocol    = "tcp"
      cidr_blocks = ["193.200.101.50/32"]
      self        = null
      description = "FTPS from BJ network"
    },
    {
      key         = "ftps_bj_dr"
      type        = "ingress"
      from_port   = 990
      to_port     = 990
      protocol    = "tcp"
      cidr_blocks = ["194.50.80.180/32"]
      self        = null
      description = "FTPS from BJ DR network"
    },
    {
      key         = "ftps_gez"
      type        = "ingress"
      from_port   = 990
      to_port     = 990
      protocol    = "tcp"
      cidr_blocks = ["82.22.173.9/32"]
      self        = null
      description = "FTPS from Gez network"
    },
    {
      key         = "ephemeral_envoy"
      type        = "ingress"
      from_port   = 40000
      to_port     = 50000
      protocol    = "tcp"
      cidr_blocks = ["157.231.92.5/32"]
      self        = null
      description = "Ephemeral from Envoy network"
    },
    {
      key         = "ephemeral_bj"
      type        = "ingress"
      from_port   = 40000
      to_port     = 50000
      protocol    = "tcp"
      cidr_blocks = ["193.200.101.50/32"]
      self        = null
      description = "Ephemeral from BJ network"
    },
    {
      key         = "ephemeral_bj_dr"
      type        = "ingress"
      from_port   = 40000
      to_port     = 50000
      protocol    = "tcp"
      cidr_blocks = ["194.50.80.180/32"]
      self        = null
      description = "Ephemeral from BJ DR network"
    },
    {
      key         = "ephemeral_gez"
      type        = "ingress"
      from_port   = 40000
      to_port     = 50000
      protocol    = "tcp"
      cidr_blocks = ["82.22.173.9/32"]
      self        = null
      description = "Ephemeral from Gez network"
    },
    {
      key         = "ssh_gr_home"
      type        = "ingress"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["82.22.173.9/32"]
      self        = null
      description = "SSH from GR home"
    }
  ]

  create_before_destroy = true
  preserve_security_group_id = true
}