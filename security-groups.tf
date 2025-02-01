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
      cidr_blocks = ["154.59.148.74/32"]
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
