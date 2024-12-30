#########################
# WireGuard VPN Instance
#########################

module "ec2_wireguard_vpn" {
  source = "cloudposse/ec2-instance/aws"
  version     = "1.6.1"
  
  namespace          = var.account_type
  stage              = var.env
  name               = "${var.name}-wireguard-vpn"
  
  vpc_id                       = module.vpc.vpc_id
  subnet                       = module.dynamic_subnets.public_subnet_ids[0]
  security_groups              = [module.wireguard_vpn_sg.id]
  security_group_enabled       = false
  associate_public_ip_address  = true
  ami                          = var.wireguard_ami
  ssh_key_pair                 = var.ssh_key_pair
  instance_type                = var.wireguard_instance_type
  private_ip                   = "10.1.0.112"
  ssm_patch_manager_enabled    = true
  instance_profile             = ""
  root_volume_size             = 10
  root_volume_type             = "gp3"
  root_iops                    = "3000"
  root_throughput              = "125"
  root_block_device_kms_key_id = module.kms_cmk_ebs.key_arn
  disable_alarm_action         = true
  tags = {Backup = true}
}

#########################
# Windows SMB Instance
#########################

module "ec2_windows_smb" {
  source = "cloudposse/ec2-instance/aws"
  version     = "1.6.1"
  
  namespace          = var.account_type
  stage              = var.env
  name               = "${var.name}-windows-fileserver"
  
  vpc_id                       = module.vpc.vpc_id
  subnet                       = module.dynamic_subnets.private_subnet_ids[0]
  security_groups              = [module.windows_smb_sg.id]
  security_group_enabled       = false
  associate_public_ip_address  = false
  ami                          = var.windows_smb_ami
  ssh_key_pair                 = var.ssh_key_pair
  instance_type                = var.windows_smb_instance_type
  private_ip                   = "10.1.0.12"
  ssm_patch_manager_enabled    = true
  instance_profile             = ""
  root_volume_size             = 40
  root_volume_type             = "gp3"
  root_iops                    = "3000"
  root_throughput              = "125"
  root_block_device_kms_key_id = module.kms_cmk_ebs.key_arn
  ebs_volume_count             = 1
  ebs_volume_size              = 300
  ebs_volume_type              = "gp3"
  ebs_throughput               = 125
  ebs_iops                     = 3000
  ebs_device_name              = ["/dev/xvdb"]
  kms_key_id                   = module.kms_cmk_ebs.key_arn
  disable_alarm_action         = true
  tags = {Backup = true}
}