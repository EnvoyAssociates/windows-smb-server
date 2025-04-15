region = "eu-west-2"
account = "339712908298"
account_type = "envoy-associates"
env = "prod2"
name = "smb"

## EC2 instances
// Shared
ssh_key_pair = "EnvoyAssociatesProd2Key"

// Wireguard VPN
wireguard_instance_type = "t3a.micro"
wireguard_ami = "ami-06523eeaf4c1ae991"

// Windows SMB File Server
windows_smb_instance_type = "t3a.medium"
windows_smb_ami = "ami-0137a390af578b3e9"

// FTPS Server
ftps_server_instance_type = "t3.micro"
ftps_server_ami = "ami-0634f20aa0764d177"

## AWS Backup
backup_kms_key_arn = "arn:aws:kms:eu-west-2:339712908298:key/945914c6-dcf1-4ca0-8a2f-ae0d7e4dae28"