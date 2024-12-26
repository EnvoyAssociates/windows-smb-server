#########################
# SMB File Server
#########################

module "smb_fileserver_sg" {
  source = "cloudposse/security-group/aws"
  version = "2.2.0"
  
  attributes = ["${var.account_type}-${var.env}", "sftp-sg"]
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
    }
  ]

  # rules_map = {
  #   ingress = [
  #   {
  #     key         = "sftp_mule_server"
  #     type        = "ingress"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     source_security_group_id = module.mule_sg.id
  #     self        = null
  #     description = "Mule Server Security Group"
  #   },
  #   {
  #     key         = "sftp_websphere_server"
  #     type        = "ingress"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     source_security_group_id = module.websphere_sg.id
  #     self        = null
  #     description = "Websphere Server Security Group"
  #   },
  #   {
  #     key         = "sftp_db_server"
  #     type        = "ingress"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     source_security_group_id = module.db_sg.id
  #     self        = null
  #     description = "Database Server Security Group"
  #   }
  #   ]
  # }

  create_before_destroy = true
  preserve_security_group_id = true
}