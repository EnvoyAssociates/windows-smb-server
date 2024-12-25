
# ################################################################################
# # EC2 Security Groups
# ################################################################################

// WireGuard VPN
module "wireguardvpn_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "wireguard-vpn-sg"
  description = "Security group for WireGuard VPN"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
	  {
      from_port   = 51820
      to_port     = 51820
      protocol    = "udp"
      cidr_blocks = "157.231.92.5/32"
      description = "ICMP from Envoy Office"
    },
	  {
      rule        = "all-icmp"
      cidr_blocks = "192.168.1.0/24"
      description = "ICMP from Envoy Office"
    },
	  {
      rule        = "all-icmp"
      cidr_blocks = "154.59.148.72/32"
      description = "ICMP from GR home"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "154.59.148.72/32"
      description = "SSH from GR home"
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      cidr_blocks = "192.168.1.0/24"
      description = "SMB from Envoy Office"
    }
  ]

    egress_with_cidr_blocks = [
    {
      rule        = "all-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "All outbound traffic"
    },
  ]

  create_before_destroy = true
  preserve_security_group_id = true

}

// File Server
module "fileserver_sg" {
  source = "terraform-aws-modules/security-group/aws"
  version = "5.2.0"

  name        = "fileserver-sg"
  description = "Security group for File Server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
	  {
      rule        = "all-icmp"
      cidr_blocks = "157.231.92.5/32"
      description = "ICMP from Envoy Office"
    },
	  {
      rule        = "all-icmp"
      cidr_blocks = "154.59.148.72/32"
      description = "ICMP from GR home"
    },
	  {
      rule        = "all-icmp"
      cidr_blocks = "10.1.0.0/24"
      description = "ICMP from VPC network"
    },
    {
      from_port   = 445
      to_port     = 445
      protocol    = "tcp"
      cidr_blocks = "10.1.0.0/24"
      description = "SMB from VPC network"
    }
#    {
#      rule        = "rdp-tcp"
#      cidr_blocks = "154.59.148.72/32"
#      description = "RDP from GR home"
#    },
  ]

    egress_with_cidr_blocks = [
    {
      rule        = "all-tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "All outbound traffic"
    },
  ]

  create_before_destroy = true
  preserve_security_group_id = true

}