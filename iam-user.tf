resource "aws_iam_user" "s3_user" {
  name = "s3_full_access_user_for_${var.name}"
}

resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

resource "aws_iam_user_policy" "s3_full_access" {
  name = "s3_full_access"
  user = aws_iam_user.s3_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "s3:*"
        Effect = "Allow"
        Resource = [
          aws_s3_bucket.static_bucket.arn,
          "${aws_s3_bucket.static_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_policy" "s3policyforOAI" {
  bucket = aws_s3_bucket.static_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject"],
        Effect   = "Allow",
        Resource = "${aws_s3_bucket.static_bucket.arn}/*",
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.newOAI.id}"
        }
      }
    ]
  })
}
