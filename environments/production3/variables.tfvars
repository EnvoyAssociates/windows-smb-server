region = "eu-west-2"
account = "160027201044"
account_type = "envoy-associates"
env = "prod3"
name = "smb"

## EC2 instances
// Shared
ssh_key_pair = "EnvoyAssociatesProd3Key" // manually create and update this

// Wireguard VPN
wireguard_instance_type = "t3.micro" // "t3a.micro"
wireguard_ami = "ami-05689a1e7da3a84a5" // update after snapshot copy and AMI creation

// Windows SMB File Server
windows_smb_instance_type = "t3.small" // "t3a.medium"
windows_smb_ami = "ami-00720a1e945d249b8" // update after snapshot copy and AMI creation

// FTPS Server
ftps_server_instance_type = "t3.micro"
ftps_server_ami = "ami-04dc962be3e2fd7c0" // update after snapshot copy and AMI creation

## AWS Backup
backup_kms_key_arn = "arn:aws:kms:eu-west-2:160027201044:key/98957838-e1e3-41ca-af0a-1fcdde58fcbe" // update this after initial deployment