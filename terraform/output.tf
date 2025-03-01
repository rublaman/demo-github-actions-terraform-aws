output "environment" {
  description = "Entorno desplegado"
  value       = var.environment
}

output "region" {
  description = "Región de AWS donde se desplegaron los recursos"
  value       = var.aws_region
}

# Outputs de los buckets desde el módulo
output "landing_bucket_id" {
  description = "ID del bucket de landing"
  value       = module.s3_buckets.landing_bucket_id
}

output "raw_bucket_id" {
  description = "ID del bucket raw"
  value       = module.s3_buckets.raw_bucket_id
}

output "curated_bucket_id" {
  description = "ID del bucket curated"
  value       = module.s3_buckets.curated_bucket_id
}

output "ready_bucket_id" {
  description = "ID del bucket ready"
  value       = module.s3_buckets.ready_bucket_id
}

output "all_bucket_ids" {
  description = "Lista de todos los IDs de buckets creados"
  value       = module.s3_buckets.all_bucket_ids
}