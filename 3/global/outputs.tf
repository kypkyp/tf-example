output "s3_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "the ARN of the s3 bucket of terraform backend"
}
