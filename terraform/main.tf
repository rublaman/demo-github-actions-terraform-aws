provider "aws" {
  region = var.aws_region
}

module "s3_ingest" {
  source      = "../modules/s3"
  bucket_name = var.ingest_bucket_name
  environment = var.environment
}

module "s3_processed" {
  source      = "../modules/s3"
  bucket_name = var.processed_bucket_name
  environment = var.environment
}
