output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3_bucket.bucket_arn
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3_bucket.bucket_name
}

output "s3_bucket_region" {
  description = "The AWS region of the S3 bucket"
  value       = module.s3_bucket.bucket_region
}
