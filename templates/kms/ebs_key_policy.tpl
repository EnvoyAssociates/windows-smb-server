{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Enable IAM policies",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${account}:root"
       },
      "Action": "kms:*",
      "Resource": "arn:aws:kms:${region}:${account}:key/*"
    },
    {
      "Sid": "Allow access through EBS for all principals in the account that are authorized to use EBS",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:CreateGrant",
        "kms:DescribeKey"
      ],
      "Resource": "arn:aws:kms:${region}:${account}:key/*",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "ec2.${region}.amazonaws.com",
          "kms:CallerAccount": "${account}"
        }
      }
    },
    {
      "Sid": "Allow use of the key by authorized Backup principal",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws-backup-role-arn}"
      },
      "Action": [
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:GenerateDataKeyWithoutPlaintext"
      ],
      "Resource": "arn:aws:kms:${region}:${account}:key/*",
      "Condition": {
          "StringEquals": {
              "kms:ViaService": "backup.${region}.amazonaws.com",
              "kms:CallerAccount": "${account}"
          }
      }
    },
    {
      "Sid": "Allow use of the key",
      "Effect": "Allow",
      "Principal": {
          "AWS": [
            "arn:aws:iam::${account}:root"
            ]
      },
      "Action": [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:GenerateDataKeyWithoutPlaintext"
      ],
      "Resource": "arn:aws:kms:${region}:${account}:key/*"
    },
    {
      "Sid": "Allow attachment of persistent resources",
      "Effect": "Allow",
      "Principal": {
          "AWS": [
            "arn:aws:iam::${account}:root"
            ]
      },
      "Action": [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
      ],
      "Resource": "arn:aws:kms:${region}:${account}:key/*",
      "Condition": {
          "Bool": {
              "kms:GrantIsForAWSResource": true
                }
          }
    }
  ]
}