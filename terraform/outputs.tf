output "cloudfront_url" {
  description = "CloudFront distribution URL"
  value       = "https://${aws_cloudfront_distribution.multi_origin.domain_name}"
}

output "cloudfront_domain" {
  description = "CloudFront domain for testing"
  value       = aws_cloudfront_distribution.multi_origin.domain_name
}

output "primary_bucket_website" {
  description = "Primary S3 bucket website endpoint"
  value       = aws_s3_bucket_website_configuration.origin_primary.website_endpoint
}

output "secondary_bucket_website" {
  description = "Secondary S3 bucket website endpoint"
  value       = aws_s3_bucket_website_configuration.origin_secondary.website_endpoint
}

output "test_urls" {
  description = "URLs to test the setup"
  value = {
    root_path      = "https://${aws_cloudfront_distribution.multi_origin.domain_name}/"
    devops_folder  = "https://${aws_cloudfront_distribution.multi_origin.domain_name}/devops-folder/"
  }
}

output "primary_bucket_name" {
  description = "Primary S3 bucket name"
  value       = aws_s3_bucket.origin_primary.id
}

output "secondary_bucket_name" {
  description = "Secondary S3 bucket name"
  value       = aws_s3_bucket.origin_secondary.id
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.multi_origin.id
}
