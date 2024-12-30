#########################
# KMS CMK EBS 
#########################

module "kms_cmk_ebs" {
  source                  = "cloudposse/kms-key/aws"
  version                 = "0.12.2"
  namespace               = var.account_type
  stage                   = var.env
  name                    = "${var.name}-kms-cmk-ebs"
  description             = "KMS key for EBS encyption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy = templatefile("${path.module}/templates/kms/ebs_key_policy.tpl", {
    region                  = var.region
    account                 = var.account
    aws-backup-role-arn = aws_iam_role.aws_backup_role.arn
    aws-backup-role-name = aws_iam_role.aws_backup_role.name
  })
}