region = "eu-west-2"
account = "517553980935"
account_type = "envoy-associates"
env = "prod1"
name = "smb"

## EC2 instances
// Shared
ssh_key_pair = "EnvoyAssociatesProd1Key"

// Wireguard VPN
wireguard_instance_type = "t3a.micro"
wireguard_ami = "ami-06daac509a9b90d62"

// Windows SMB File Server
windows_smb_instance_type = "t3a.medium"
windows_smb_ami = "ami-0733fe3797ab02f5f"

## AWS Backup
backup_kms_key_arn = "arn:aws:kms:eu-west-2:517553980935:key/4fed8181-a4e0-4606-af46-32ea922f41d5"