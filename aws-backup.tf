#####################
# Backup Vault
#####################
resource "aws_backup_vault" "backup_vault" {
  name = "${var.account_type}-${var.env}-${var.name}-vault"
  kms_key_arn = var.backup_kms_key_arn
}

#####################
# EC2 Backups (Without replication)
#####################
resource "aws_backup_plan" "backup_plan_ec2_without_copy" {
  name = "${var.account_type}-${var.env}-${var.name}-plan-ec2"

  rule {
    rule_name         = "${var.account_type}-${var.env}-${var.name}-daily"
    target_vault_name = aws_backup_vault.backup_vault.name
    schedule          = "cron(0 2 ? * SUN-SAT *)"
    start_window = 60
    completion_window = 120

    lifecycle {
      delete_after = 7
    }
    
    recovery_point_tags = {
      Product = var.account_type
      Role    = "${var.account_type}-${var.env}-${var.name}-awsbackup-role"
      Creator = "aws-backup"
    }
  }
}

// EC2 resources
resource "aws_backup_selection" "ec2-backup-selection_without_copy" {
  iam_role_arn = aws_iam_role.aws_backup_role.arn
  name         = "${var.account_type}-${var.env}-${var.name}-server-resources"
  plan_id      = aws_backup_plan.backup_plan_ec2_without_copy.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "true"
  }

  condition {
    string_like {
      key   = "aws:ResourceTag/Stage"
      value = "${var.env}"
    }
  }

  not_resources = [
    "arn:aws:ec2:${var.region}:${var.account}:volume/vol-*",
  ]
  
}
