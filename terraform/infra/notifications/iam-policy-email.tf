resource "aws_iam_policy" "email_policy" {
  name = "${var.environment}-email-policy"

  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
      Action = [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ]
      Effect   = "Allow"
      Resource = aws_sqs_queue.email.arn
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
  ]
})
}
