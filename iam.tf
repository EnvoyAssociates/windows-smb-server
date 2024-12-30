
// AWS managed
data "aws_iam_policy" "AWSBackupServiceRolePolicyForBackup" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}

data "aws_iam_policy" "AWSBackupServiceRolePolicyForRestores" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForRestores"
}

// AWS Backup trust
data "aws_iam_policy_document" "aws_backup_assume_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = [
          "backup.amazonaws.com"
          ]
    }
  }
}

#########################
# AWS Backup Role
#########################

resource "aws_iam_role" "aws_backup_role" {
  name = "${var.account_type}-${var.env}-${var.name}-awsbackup-role"
  assume_role_policy = data.aws_iam_policy_document.aws_backup_assume_policy.json
}

resource "aws_iam_role_policy_attachment" "AWSBackupServiceRolePolicyForBackup" {
  role = aws_iam_role.aws_backup_role.name
  policy_arn = data.aws_iam_policy.AWSBackupServiceRolePolicyForBackup.arn
}

resource "aws_iam_role_policy_attachment" "AWSBackupServiceRolePolicyForRestores" {
  role = aws_iam_role.aws_backup_role.name
  policy_arn = data.aws_iam_policy.AWSBackupServiceRolePolicyForRestores.arn
}