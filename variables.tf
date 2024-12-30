
variable "region" {
  type        = string
  description = "region"
}

variable "account" {
  type        = string
  description = "account"
}

variable "account_type" {
  type        = string
  description = "account_type"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Function name"
}

## EC2 instances
// Shared
variable "ssh_key_pair" {
  type        = string
  description = "EC2 key pair"
}

// Wireguard VPN
variable "wireguard_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "wireguard_ami" {
  type        = string
  description = "EC2 AMI"
}

// Windows SMB File Server
variable "windows_smb_instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "windows_smb_ami" {
  type        = string
  description = "EC2 AMI"
}

## AWS Backup
variable "backup_kms_key_arn" {
  type        = string
  description = "Vault encryption key"
}
