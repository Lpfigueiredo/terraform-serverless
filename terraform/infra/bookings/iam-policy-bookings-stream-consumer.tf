resource "aws_iam_policy" "bookings_stream_consumer_policy" {
  name = "${var.environment}-bookings-stream-consumer-policy"

  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action = [
        "dynamodb:DescribeStream",
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:ListStreams"
      ]
      Effect   = "Allow"
      Resource = aws_dynamodb_table.bookings.stream_arn
    },
    {
      "Effect": "Allow",
      "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
    , 
    {
      Action = [
        "sns:Publish",
      ]
      Effect   = "Allow"
      Resource = var.sns_notifications_arn
    }
  ]
})
}
