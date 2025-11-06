resource "aws_s3_bucket" "origin_primary" {
  bucket = "${var.project_name}-primary-origin-${random_id.bucket_suffix.hex}"
  force_destroy       = true
  
  tags = {
    Name        = "Primary Origin Bucket"
    Assignment  = "BlueStacks DevOps Challenge"
    Origin      = "primary"
  }
}

resource "aws_s3_bucket_website_configuration" "origin_primary" {
  bucket = aws_s3_bucket.origin_primary.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
resource "aws_s3_bucket_policy" "origin_primary_policy" {
  bucket = aws_s3_bucket.origin_primary.id
  depends_on = [aws_s3_bucket_public_access_block.origin_primary]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.origin_primary.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "origin_primary" {
  bucket = aws_s3_bucket.origin_primary.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket" "origin_secondary" {
  bucket = "${var.project_name}-secondary-origin-${random_id.bucket_suffix.hex}"
  force_destroy       = true
  
  tags = {
    Name        = "Secondary Origin Bucket"
    Assignment  = "BlueStacks DevOps Challenge"
    Origin      = "secondary"
  }
}

resource "aws_s3_bucket_website_configuration" "origin_secondary" {
  bucket = aws_s3_bucket.origin_secondary.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
resource "aws_s3_bucket_policy" "origin_secondary_policy" {
  bucket = aws_s3_bucket.origin_secondary.id
  depends_on = [aws_s3_bucket_public_access_block.origin_secondary]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.origin_secondary.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "origin_secondary" {
  bucket = aws_s3_bucket.origin_secondary.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "random_id" "bucket_suffix" {
  byte_length = 4
}
