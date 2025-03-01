output "landing_bucket_id" {
  description = "ID del bucket de landing"
  value       = aws_s3_bucket.landing_bucket.id
}

output "landing_bucket_arn" {
  description = "ARN del bucket de landing"
  value       = aws_s3_bucket.landing_bucket.arn
}

output "raw_bucket_id" {
  description = "ID del bucket raw"
  value       = aws_s3_bucket.raw_bucket.id
}

output "raw_bucket_arn" {
  description = "ARN del bucket raw"
  value       = aws_s3_bucket.raw_bucket.arn
}

output "curated_bucket_id" {
  description = "ID del bucket curated"
  value       = aws_s3_bucket.curated_bucket.id
}

output "curated_bucket_arn" {
  description = "ARN del bucket curated"
  value       = aws_s3_bucket.curated_bucket.arn
}

output "ready_bucket_id" {
  description = "ID del bucket ready"
  value       = aws_s3_bucket.ready_bucket.id
}

output "ready_bucket_arn" {
  description = "ARN del bucket ready"
  value       = aws_s3_bucket.ready_bucket.arn
}

output "all_bucket_ids" {
  description = "Lista de todos los IDs de buckets creados"
  value = [
    aws_s3_bucket.landing_bucket.id,
    aws_s3_bucket.raw_bucket.id,
    aws_s3_bucket.curated_bucket.id,
    aws_s3_bucket.ready_bucket.id
  ]
}

output "all_bucket_arns" {
  description = "Lista de todos los ARNs de buckets creados"
  value = [
    aws_s3_bucket.landing_bucket.arn,
    aws_s3_bucket.raw_bucket.arn,
    aws_s3_bucket.curated_bucket.arn,
    aws_s3_bucket.ready_bucket.arn
  ]
}