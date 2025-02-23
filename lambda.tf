
data "archive_file" "lambda_ec2_start" {
  type        = "zip"
  source_dir  = "${path.module}/templates/lambda/StartEC2Instances"
  output_path = "lambda-ec2-start.zip"
}

data "archive_file" "lambda_ec2_stop" {
  type        = "zip"
  source_dir  = "${path.module}/templates/lambda/StopEC2Instances"
  output_path = "lambda-ec2-stop.zip"
}

data "aws_iam_policy_document" "lambda_ec2" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:${var.region}:${var.account}:*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:Start*",
      "ec2:Stop*"
    ]
    resources = [module.ec2_wireguard_vpn.arn, module.ec2_windows_smb.arn, "arn:aws:ec2:eu-west-2:517553980935:instance/i-04c464f44456c98fe"]
  }

}

// EC2 start
resource "aws_iam_role_policy" "lambda_ec2_start" {
  role   = module.lambda_ec2_start.role_name
  policy = data.aws_iam_policy_document.lambda_ec2.json
}

module "lambda_ec2_start" {
  source  = "cloudposse/lambda-function/aws"
  version = "0.5.5"

  filename                       = data.archive_file.lambda_ec2_start.output_path
  source_code_hash               = data.archive_file.lambda_ec2_start.output_base64sha256
  function_name                  = "${var.account_type}-${var.env}-${var.name}-lambda-ec2-start"
  description                    = "Lambda function that starts EC2 instances based on schedule"
  handler                        = "main.lambda_handler"
  runtime                        = "python3.13"
  timeout                        = 60

  lambda_environment = {
    variables= {
        Region = "${var.region}",
        Instances = "${module.ec2_wireguard_vpn.id},${module.ec2_windows_smb.id},i-04c464f44456c98fe"
    }
  }
}

resource "aws_lambda_permission" "ec2_weekday_start" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_ec2_start.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_weekday_start.arn
}

resource "aws_lambda_permission" "ec2_weekend_start" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_ec2_start.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_weekend_start.arn
}

// EC2 stop
resource "aws_iam_role_policy" "lambda_ec2_stop" {
  role   = module.lambda_ec2_stop.role_name
  policy = data.aws_iam_policy_document.lambda_ec2.json
}

module "lambda_ec2_stop" {
  source  = "cloudposse/lambda-function/aws"
  version = "0.5.5"

  filename                       = data.archive_file.lambda_ec2_stop.output_path
  source_code_hash               = data.archive_file.lambda_ec2_stop.output_base64sha256
  function_name                  = "${var.account_type}-${var.env}-${var.name}-lambda-ec2-stop"
  description                    = "Lambda function that stops EC2 instances based on schedule"
  handler                        = "main.lambda_handler"
  runtime                        = "python3.13"
  timeout                        = 60

  lambda_environment = {
    variables= {
        Region = "${var.region}",
        Instances = "${module.ec2_wireguard_vpn.id},${module.ec2_windows_smb.id},i-04c464f44456c98fe"
    }
  }
}

resource "aws_lambda_permission" "ec2_weekday_stop" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_ec2_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_weekday_stop.arn
}

resource "aws_lambda_permission" "ec2_weekend_stop" {
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_ec2_stop.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.ec2_weekend_stop.arn
}
