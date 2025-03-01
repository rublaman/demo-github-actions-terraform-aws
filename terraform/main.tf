terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.11.0"

  backend "s3" {
    # Estos valores serán proporcionados durante terraform init
    # No se pueden usar variables aquí
  }
}

# Módulo para crear los buckets S3 requeridos
module "s3_buckets" {
  source = "./modules/s3"

  environment         = var.environment
  project_name        = "rublaman"
  bucket_landing_name = var.s3_bucket_landing
  bucket_raw_name     = var.s3_bucket_raw
  bucket_curated_name = var.s3_bucket_curated
  bucket_ready_name   = var.s3_bucket_ready
}