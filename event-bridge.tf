
locals {
  weekday_start = "cron(0 6 ? * MON-FRI *)" // Daylight saving
  weekday_stop  = "cron(0 18 ? * MON-SUN *)" // Daylight saving
  weekend_start = "cron(0 8 ? * SAT *)" // Daylight saving
  weekend_stop  = "cron(0 12 ? * SAT *)" // Daylight saving
  # weekday_start = "cron(0 7 ? * MON-FRI *)" // Not daylight saving
  # weekday_stop  = "cron(0 19 ? * MON-SUN *)" // Not daylight saving
  # weekend_start = "cron(0 9 ? * SAT *)" // Not daylight saving
  # weekend_stop  = "cron(0 13 ? * SAT *)" // Not daylight saving
}

#########################
# EC2 Scheduled Start
#########################

// EC2 Weekday start
resource "aws_cloudwatch_event_rule" "ec2_weekday_start" {
  name                = "weekday-schedule-${module.lambda_ec2_start.function_name}"
  schedule_expression = local.weekday_start
}

resource "aws_cloudwatch_event_target" "ec2_weekday_start" {
  target_id = "event-target-${module.lambda_ec2_start.function_name}"
  rule      = aws_cloudwatch_event_rule.ec2_weekday_start.name
  arn       = module.lambda_ec2_start.arn
}

// EC2 Weekend start
resource "aws_cloudwatch_event_rule" "ec2_weekend_start" {
  name                = "weekend-schedule-${module.lambda_ec2_start.function_name}"
  schedule_expression = local.weekend_start
}

resource "aws_cloudwatch_event_target" "ec2_weekend_start" {
  target_id = "event-target-${module.lambda_ec2_start.function_name}"
  rule      = aws_cloudwatch_event_rule.ec2_weekend_start.name
  arn       = module.lambda_ec2_start.arn
}

#########################
# EC2 Scheduled Stop
#########################

// EC2 Weekday stop
resource "aws_cloudwatch_event_rule" "ec2_weekday_stop" {
  name                = "weekday-schedule-${module.lambda_ec2_stop.function_name}"
  schedule_expression = local.weekday_stop
}

resource "aws_cloudwatch_event_target" "ec2_weekday_stop" {
  target_id = "event-target-${module.lambda_ec2_stop.function_name}"
  rule      = aws_cloudwatch_event_rule.ec2_weekday_stop.name
  arn       = module.lambda_ec2_stop.arn
}

// EC2 Weekend stop
resource "aws_cloudwatch_event_rule" "ec2_weekend_stop" {
  name                = "weekend-schedule-${module.lambda_ec2_stop.function_name}"
  schedule_expression = local.weekend_stop
}

resource "aws_cloudwatch_event_target" "ec2_weekend_stop" {
  target_id = "event-target-${module.lambda_ec2_stop.function_name}"
  rule      = aws_cloudwatch_event_rule.ec2_weekend_stop.name
  arn       = module.lambda_ec2_stop.arn
}
